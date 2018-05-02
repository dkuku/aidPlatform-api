Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
#      get '/tasks/:task_id', to: 'conversations#index'
      post '/conversations/:conversation_id', to: 'messages#create'
      get '/conversations/:conversation_id', to: 'conversations#index'
      devise_scope :user do
        post 	'sign_up', to: 'registrations#create'
        post 	'sign_in', to: 'sessions#create'
        patch 	'user', to: 'sessions#update'
		    delete 	'log_out', to: 'sessions#destroy'
      end

      resources :tasks, only: [:index, :show, :create, :update, :destroy] 
      resources :conversations, only: [:show, :create, :destroy]
    end
  end
  mount ActionCable.server, at: '/stats'
end
