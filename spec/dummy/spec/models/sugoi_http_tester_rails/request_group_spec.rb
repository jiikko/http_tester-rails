require 'rails_helper'
require 'pry'

describe SugoiHttpTesterRails::RequestGroup do
  it 'サバーエラーを許容回数までリクエストし続けること' do
    project = SugoiHttpTesterRails::Project.create!(name: :test_project)
    template_request_group = project.template_request_groups.create!
    auth = SugoiHttpTesterRails::HostBasicAuth.create!(title: :none, basic_auth_username: '', basic_auth_password: '')
    testing_host = project.testing_hosts.create!(name: 'example.com', host_basic_auth: auth)
    request_group = testing_host.request_groups.create!

    success_results = 20.times.map do
      { path:        '/',
        device_type: :sp,
        method: 'GET',
        status_code: 200 }
    end
    server_error_resullts = 20.times.map do
      { path:        '/',
        device_type: :sp,
        method: 'GET',
        status_code: 500 }
    end
    allow_any_instance_of(template_request_group.class).to receive(:separation_run).and_return(
      server_error_resullts + success_results
    )
    request_group.run_http_test!(template_request_group: template_request_group)
    expect(request_group.requests.count).to eq 1

    allow_any_instance_of(template_request_group.class).to receive(:separation_run).and_return(
      success_results + server_error_resullts
    )
    request_group.run_http_test!(template_request_group: template_request_group)
    expect(request_group.requests.count).to eq 22
  end
end
