class SugoiHttpTesterRails::ProjectsController < ApplicationController
  def index
    @projects = SugoiHttpTesterRails::Project.all
  end

  def show
    @project = SugoiHttpTesterRails::Project.find(params[:id])
    @template_request_groups = SugoiHttpTesterRails::TemplateRequestGroup.order(id: :desc)
  end

  def new
    @project = SugoiHttpTesterRails::Project.new
  end

  def create
    @project = SugoiHttpTesterRails::Project.new(project_param)
    if @project.save
      redirect_to @project, notice: 'プロジェクトを作成しました'
    else
      render :new
    end
  end

  private

  def project_param
    params.required(:project).permit(:name)
  end
end
