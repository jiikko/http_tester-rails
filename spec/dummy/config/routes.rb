Rails.application.routes.draw do
  mount SugoiHttpTesterRails::Engine => "/http_tester"
end
