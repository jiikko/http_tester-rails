class SugoiHttpTesterRails::Request < ActiveRecord::Base
  include SugoiHttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)
end
