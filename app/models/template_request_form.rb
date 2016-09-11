class SugoiHttpTesterRails::TemplateRequestForm
  include ActiveModel::Model

  attr_accessor :log_file, :project_id

  def initialize(request_form_params)
    super
    if request_form_params && request_form_params[:log_file]
      @file = request_form_params[:log_file]
    end
  end

  def valid?
    !!@file
  end

  def delay_import
    SugoiHttpTesterRails::Project.find(project_id).import_from(@file)
  end
end
