class HttpTesterRails::Request < ActiveRecord::Base
  include HttpMethodModule

  enum device_type: %i(pc sp)
end
