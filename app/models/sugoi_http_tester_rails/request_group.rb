class SugoiHttpTesterRails::RequestGroup < ActiveRecord::Base
  include SugoiHttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)

  belongs_to :testing_host

  has_many :requests

  def self.count_server_error(total_count, list)
    list.each do |result|
      if result && (/^5../ =~ result[:status_code].to_s)
        total_count = total_count + 1
      end
    end
    total_count
  end

  def path_with_params
    return path if params.blank?
    "#{path}?#{params}"
  end

  def run_http_test_with_delay!(template_request_group: )
    delay.run_http_test!(template_request_group: template_request_group)
  end

  def run_http_test!(template_request_group: )
    server_error_counter = 0
    (1..max_page).each do |page|
      separate_run(page).each do |result|
        next unless result[:status_code] # GET 以外はnilが入っているのでnextする
        self.requests.create!(
          path:        result[:path],
          device_type: result[:device_type],
          http_method: SugoiHttpTesterRails::HttpMethodModule::HTTP_METHOD_TABLE[result[:method]],
          status_code: result[:status_code],
        )

        if result && (500..599).include?(result[:status_code])
          server_error_counter = server_error_counter + 1
          if server_error_counter >= testing_host.allowed_failure_count
            return
          end
        end
      end
    end
  end

  private

  def separate_run(page)
    http_tester = build_http_tester
    http_tester.import_request_list_from(
      template_request_group.template_requests.
        order(:id).
        page(page).
        per(SugoiHttpTesterRails::Project::COUNT_OF_TEST_GROUP).
        map do |req|
        { method: req.popular_http_method,
          path: req.path_with_params.force_encoding('UTF-8'),
          device_type: req.device_type.to_sym,
        }
      end
    )
    http_tester.run(output_format: :array) # return Hash of Array
  end

  def max_page
    m_page = template_request_group.template_requests.count / SugoiHttpTesterRails::Project::COUNT_OF_TEST_GROUP
    m_page.zero? ? 1 : m_page
  end

  def build_http_tester
    SugoiHttpRequestTester.new(
      host: testing_host.name,
      limit: 1000000000, # 適当
      logs_path: nil,
      concurrency: 4,
      basic_auth: [testing_host.host_basic_auth.basic_auth_username, testing_host.host_basic_auth.basic_auth_password],
    )
  end
end
