Rails.application.routes.draw do

  mount HttpTesterRails::Engine => "/http_tester_rails"
end
