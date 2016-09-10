class HttpTesterRails::TestingHostsController < ApplicationController
  def index
    @project = HttpTesterRails::Project.find(params[:project_id])
    @testing_hosts = @project.testing_hosts.find(params[:project_id])
    @testing_host
  end

  def new
    @project = HttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.build
  end

  def show
    @project = HttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.find(params[:id])
    @template_request_groups = HttpTesterRails::TemplateRequestGroup.all
  end

  def create
    @project = HttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.build(testing_host_params)
    if @testing_host.save
      redirect_to http_tester_project_testing_host_path(@project, @testing_host), notice: '作成しました'
    else
      render :new
    end
  end

  private

  def testing_host_params
    params.required(:http_tester_testing_host).permit!
  end
end
