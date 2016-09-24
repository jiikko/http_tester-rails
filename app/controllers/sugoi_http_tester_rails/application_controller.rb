module SugoiHttpTesterRails
  class ApplicationController < ActionController::Base
    layout 'sugoi_http_tester_rails'
    protect_from_forgery with: :exception
  end
end
