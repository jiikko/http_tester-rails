class HttpTesterRails::Request < ActiveRecord::Base
  include HttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)
end
