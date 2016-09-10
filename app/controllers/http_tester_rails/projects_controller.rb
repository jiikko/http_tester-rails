class HttpTesterRails::ProjectsController < ApplicationController
  def index
    @projects = HttpTesterRails::Project.all
  end

  def show
    @project = HttpTesterRails::Project.find(params[:id])
    @template_request_groups = HttpTesterRails::TemplateRequestGroup.order(id: :desc)
  end
end
