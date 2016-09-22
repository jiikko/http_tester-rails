class SugoiHttpTesterRails::RequestsController < ApplicationController
  before_action :set_instances, only: :index

  def index
    @status_code_type = params[:status_code_type].to_sym
    @requests = @testing_job.
      requests.
      scoped_by_status_codes(@status_code_type).
      page(params[:page])
  end

  private

  def set_instances
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = SugoiHttpTesterRails::TestingHost.find(params[:testing_host_id])
    @testing_job = SugoiHttpTesterRails::TestingJob.find(params[:testing_job_id])
  end
end
