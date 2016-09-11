class SugoiHttpTesterRails::ProjectsController < ApplicationController
  def index
    @projects = SugoiHttpTesterRails::Project.all
  end

  def show
    @project = SugoiHttpTesterRails::Project.find(params[:id])
    @template_request_groups = SugoiHttpTesterRails::TemplateRequestGroup.order(id: :desc)
  end
end
