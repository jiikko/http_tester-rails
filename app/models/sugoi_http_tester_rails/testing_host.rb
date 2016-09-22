class SugoiHttpTesterRails::TestingHost < ActiveRecord::Base
  belongs_to :project
  belongs_to :host_basic_auth

  has_many :testing_jobs, dependent: :destroy
end
