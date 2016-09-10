class HttpTesterRails::RequestGroup < ActiveRecord::Base
  include HttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)

  belongs_to :testing_host

  has_many :requests

  def path_with_params
    return path if params.blank?
    "#{path}?#{params}"
  end

  def run_http_test_with_delay!(testing_host: , template_request_group: )
    delay.run_http_test!(testing_host: testing_host, template_request_group: template_request_group)
  end

  def run_http_test!(testing_host: , template_request_group: )
    max_page = template_request_group.template_requests.count / HttpTesterRails::Project::COUNT_OF_TEST_GROUP
    max_page = max_page.zero? ? 1 : max_page
    (1..max_page).each do |page|
      template_requests = template_request_group.template_requests.
        order(:id).
        page(page).
        per(HttpTesterRails::Project::COUNT_OF_TEST_GROUP)
      tester = build_tester
      tester.import_request_list_from(
        template_requests.map do |req|
          { method: req.popular_http_method,
            path: req.path_with_params,
            path: req.path_with_params.force_encoding('UTF-8'),
            device_type: req.device_type.to_sym,
          }
        end
      )
      list = tester.run(output_format: :array)
      list.each do |hash|
        next unless hash[:status_code] # GET 以外はnil
        self.requests.create!(
          path:        hash[:path],
          device_type: hash[:device_type],
          http_method: HttpTesterRails::HttpMethodModule::HTTP_METHOD_TABLE[hash[:method]],
          status_code: hash[:status_code],
        )
      end
      # 500系のレスポンスをみつけた時点で終了する
      list.each do |result|
        if result && (/^5../ =~ result[:status_code].to_s)
          return
        end
      end
    end
  end

  private

  def build_tester
    tester = SugoiHttpRequestTester.new(
      host: testing_host.name,
      limit: 1000000000, # 適当
      logs_path: nil,
      concurrency: 4,
      basic_auth: [testing_host.host_basic_auth.basic_auth_username, testing_host.host_basic_auth.basic_auth_password],
    )
    tester
  end
end
