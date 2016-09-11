class SugoiHttpTesterRails::Report < ActiveRecord::Base
  enum :status, [:success, :failure]

  belongs_to :project
end
