class SugoiHttpTesterRails::RequestGroupsController < ApplicationController
  before_action :set_instances,     only: [:show, :request_status_abort, :create]
  before_action :set_request_group, only: [:show, :request_status_abort]

  def show
    @success_requests =      @request_group.requests.scoped_by_status_codes(:success)
    @redirect_requests =     @request_group.requests.scoped_by_status_codes(:redirect)
    @client_error_requests = @request_group.requests.scoped_by_status_codes(:client_error)
    @server_error_requests = @request_group.requests.scoped_by_status_codes(:server_error)
  end

  def request_status_abort
    if @request_group.status_executing?
      @request_group.status_aborting!
      message = '処理を停止しました'
    else
      message = '実行中ステータス以外だったので停止しませんでした'
    end
    redirect_to project_testing_host_request_group_path(@project, @testing_host, @request_group), notice: message
  end

  def create
    template_request_group = SugoiHttpTesterRails::TemplateRequestGroup.find(params[:template_request_group_id])
    request_group = @testing_host.request_groups.create!
    request_group.run_http_test_with_delay!(template_request_group: template_request_group)
    redirect_to project_testing_host_request_group_path(@project, @testing_host, request_group), notice: 'テスト中です'
  end

  private

  def set_instances
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = SugoiHttpTesterRails::TestingHost.find(params[:testing_host_id])
  end

  def set_request_group
    @request_group = SugoiHttpTesterRails::RequestGroup.find(params[:id])
  end
end
