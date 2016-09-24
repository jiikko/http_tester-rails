class SugoiHttpTesterRails::TestingJobsController < SugoiHttpTesterRails::ApplicationController
  before_action :set_instances,     only: [:show, :request_status_abort, :create]
  before_action :set_testing_job, only: [:show, :request_status_abort]

  def show
    @success_requests =      @testing_job.requests.scoped_by_status_codes(:success)
    @redirect_requests =     @testing_job.requests.scoped_by_status_codes(:redirect)
    @client_error_requests = @testing_job.requests.scoped_by_status_codes(:client_error)
    @server_error_requests = @testing_job.requests.scoped_by_status_codes(:server_error)
  end

  def request_status_abort
    if @testing_job.status_executing?
      @testing_job.status_aborting!
      message = '処理を停止しました'
    else
      message = '実行中ステータス以外だったので停止しませんでした'
    end
    redirect_to project_testing_host_testing_job_path(@project, @testing_host, @testing_job), notice: message
  end

  def create
    template_request_group = SugoiHttpTesterRails::TemplateRequestGroup.find(params[:template_request_group_id])
    testing_job = @testing_host.testing_jobs.create!
    testing_job.run_http_test_with_delay!(template_request_group: template_request_group)
    redirect_to project_testing_host_testing_job_path(@project, @testing_host, testing_job), notice: 'テスト中です'
  end

  private

  def set_instances
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = SugoiHttpTesterRails::TestingHost.find(params[:testing_host_id])
  end

  def set_testing_job
    @testing_job = SugoiHttpTesterRails::TestingJob.find(params[:id])
  end
end
