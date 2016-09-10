class HttpTesterRails::RequestGroupsController < ApplicationController
  def show
    @project = HttpTesterRails::Project.find(params[:project_id])
    @testing_host = HttpTesterRails::TestingHost.find(params[:testing_host_id])
    @request_group = HttpTesterRails::RequestGroup.find(params[:id])
    @error_requests = @request_group.requests.where(status_code: 500..510)
  end

  def create
    project = HttpTesterRails::Project.find(params[:project_id])
    testing_host = HttpTesterRails::TestingHost.find(params[:testing_host_id])
    template_request_group = HttpTesterRails::TemplateRequestGroup.find(params[:template_request_group_id])
    request_group = testing_host.request_groups.create!
    request_group.run_http_test_with_delay!(testing_host: testing_host, template_request_group: template_request_group)
    redirect_to project_testing_host_request_group_path(project, testing_host, request_group), notice: 'テスト中です'
  end
end
