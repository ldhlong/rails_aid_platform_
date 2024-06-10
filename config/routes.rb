Rails.application.routes.draw do
  get 'current_user/index'
  get 'current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'home#index'
  post '/submit_request', to: 'requests#create'
  patch 'requests/:id', to: 'requests#update'
  get 'completed_requests_count', to: 'requests#completed_requests_count'
end
