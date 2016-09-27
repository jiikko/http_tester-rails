class SugoiHttpTesterRails::TemplateRequestGroupsController < SugoiHttpTesterRails::ApplicationController
  def show
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @request_group = @project.template_request_groups.find(params[:id])
    @template_requests = @request_group.template_requests.limit(100)
    if params[:path].present?
      @template_requests = @template_requests.search(params[:path])
    end
  end

  def new
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @request_form = SugoiHttpTesterRails::TemplateRequestForm.new({})
  end

  def create
    @project = SugoiHttpTesterRails::Project.find(params[:project_id])
    @request_form = SugoiHttpTesterRails::TemplateRequestForm.new(params[:template_request_form])
    if @request_form.valid?
      @request_form.delay_import
      redirect_to project_path(@project), notice: 'ログを取り込んでいます'
    else
      render :new
    end
  end
end
