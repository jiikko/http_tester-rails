require 'rails_helper'
require 'pry'

describe SugoiHttpTesterRails::RequestGroup do
  it 'サバーエラーを許容回数までリクエストし続けること' do
    project = SugoiHttpTesterRails::Project.create!(name: :test_project)
    template_request_group = project.template_request_groups.create
    auth = SugoiHttpTesterRails::HostBasicAuth.create!(title: :none, basic_auth_username: '', basic_auth_password: '')
    testing_host = project.testing_hosts.create!(name: 'example.com', host_basic_auth: auth)
    binding.pry
  end
end
