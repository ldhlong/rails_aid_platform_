Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  # Messages routes
  resources :messages, only: [:index, :create, :update, :destroy]
  get 'messages/:conversation_id', to: 'messages#show_by_conversation', as: 'messages_by_conversation'

  # Other routes
  get 'current_user', to: 'current_user#index'

  # Devise routes with custom path names
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Root and other custom routes
  root 'home#index'
  post '/submit_request', to: 'help_requests#create'
  patch 'help_requests/:request_count', to: 'help_requests#update'
  get 'completed_requests_count', to: 'help_requests#completed_requests_count'
  get '/success', to: 'help_requests#success', as: 'success'

  # HelpRequests routes
  resources :help_requests, only: [:index, :show]  # Add :show to fetch specific help request
end
