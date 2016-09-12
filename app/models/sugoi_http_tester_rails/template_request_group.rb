class SugoiHttpTesterRails::TemplateRequestGroup < ActiveRecord::Base
  belongs_to :project

  has_many :template_requests, dependent: :destroy

  def separation_run(page, testing_host: )
    http_tester = build_http_tester(testing_host: testing_host)
    http_tester.import_request_list_from(
      template_requests.
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

  def max_page_of_test_group
    max_page = template_requests.count / SugoiHttpTesterRails::Project::COUNT_OF_TEST_GROUP
    max_page.zero? ? 1 : m_page
  end

  private

  def build_http_tester(testing_host: )
    SugoiHttpRequestTester.new(
      host: testing_host.name,
      limit: 1000000000, # 適当
      logs_path: nil,
      concurrency: 4,
      basic_auth: [
        testing_host.host_basic_auth.basic_auth_username,
        testing_host.host_basic_auth.basic_auth_password,
      ],
    )
  end
end
