SugoiHttpTesterRails::Engine.routes.draw do
  root 'projects#index'
  resources :host_basic_auths
  resources :projects do
    resources :testing_hosts do
      resources :request_groups, only: :show do
        resources :requests, only: :index
        patch :request_status_abort, on: :member
      end
      resources :template_request_groups do
        resources :request_groups, only: :create
      end
    end
    resources :template_request_groups do
      resources :template_requests
    end
  end
end
