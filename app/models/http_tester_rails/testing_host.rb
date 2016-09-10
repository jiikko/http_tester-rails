class HttpTesterRails::TestingHost < ActiveRecord::Base
  belongs_to :project
  belongs_to :host_basic_auth

  has_many :request_groups, dependent: :destroy
end
