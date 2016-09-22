class SugoiHttpTesterRails::TestingHostsController < ApplicationController
  def index
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_hosts = @project.testing_hosts.find(params[:project_id])
  end

  def new
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.build
  end

  def show
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.find(params[:id])
    @request_groups = @testing_host.request_groups.order(id: :desc).page(params[:page]).per(30)
  end

  def edit
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.find(params[:id])
  end

  def create
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.build(testing_host_params)
    if @testing_host.save
      redirect_to project_testing_host_path(@project, @testing_host), notice: '作成しました'
    else
      render :new
    end
  end

  def update
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @testing_host = @project.testing_hosts.find(params[:id])
    if @testing_host.update(testing_host_params)
      redirect_to project_testing_host_path(@project, @testing_host), notice: '更新しました'
    else
      render :new
    end
  end

  private

  def testing_host_params
    params.required(:testing_host).permit!
  end
end
