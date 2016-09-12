class SugoiHttpTesterRails::RequestGroup < ActiveRecord::Base
  include SugoiHttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)

  belongs_to :testing_host

  has_many :requests

  def path_with_params
    return path if params.blank?
    "#{path}?#{params}"
  end

  def run_http_test_with_delay!(template_request_group: )
    delay.run_http_test!(template_request_group: template_request_group)
  end

  def run_http_test!(template_request_group: )
    server_error_counter = 0
    (1..template_request_group.max_page_of_test_group).each do |page|
      template_request_group.separation_run(page, testing_host: testing_host).each do |result|
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
end
