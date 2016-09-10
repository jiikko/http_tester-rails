class HttpTesterRails::TemplateRequestGroup < ActiveRecord::Base
  belongs_to :project

  has_many :template_requests, dependent: :destroy
end
