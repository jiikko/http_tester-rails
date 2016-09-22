SugoiHttpTesterRails::Engine.routes.draw do
  root 'projects#index'
  resources :host_basic_auths
  resources :projects do
    resources :testing_hosts do
      resources :testing_jobs, only: :show do
        resources :requests, only: :index
        patch :request_status_abort, on: :member
      end
      resources :template_request_groups do
        resources :testing_jobs, only: :create
      end
    end
    resources :template_request_groups do
      resources :template_requests
    end
  end
end
