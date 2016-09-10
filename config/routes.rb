HttpTesterRails::Engine.routes.draw do
  root 'projects#index'
  resources :projects do
    resources :testing_hosts do
      resources :request_groups, only: :show
      resources :template_request_groups do
        resources :request_groups, only: :create
      end
    end
    resources :template_request_groups do
      resources :template_requests
    end
  end
end
