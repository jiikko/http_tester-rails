class SugoiHttpTesterRails::TemplateRequest < ActiveRecord::Base
  include SugoiHttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)

  belongs_to :template_request_group
end
