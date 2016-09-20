class SugoiHttpTesterRails::RequestsController < ApplicationController
  before_action :set_instances, only: :index

  def index
    @status_code_type = params[:status_code_type]
    @requests = @request_group.
      requests.
      scoped_by_status_codes(@status_code_type.to_sym).
      page(params[:page])
  end

  private

  def set_instances
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = SugoiHttpTesterRails::TestingHost.find(params[:testing_host_id])
    @request_group = SugoiHttpTesterRails::RequestGroup.find(params[:request_group_id])
  end
end
