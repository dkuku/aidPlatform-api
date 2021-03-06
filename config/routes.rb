Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
#      get '/tasks/:task_id', to: 'conversations#index'
      post '/conversations/:conversation_id', to: 'messages#create'
      get '/messages/', to: 'messages#index'
      get '/conversations/:conversation_id', to: 'conversations#index'
      delete '/conversations/:conversation_id', to: 'conversations#destroy'
      get '/statistics', to: 'statistics#index'
      post '/tasks/within', to: 'tasks#within'
      devise_scope :user do
        post 	'sign_up', to: 'registrations#create'
        post 	'sign_in', to: 'sessions#create'
        put 	'user', to: 'sessions#update'
		    delete 	'log_out', to: 'sessions#destroy'
      end

      resources :tasks, only: [:index, :show, :create, :update, :destroy] 
      resources :conversations, only: [:index, :show, :create, :destroy]
    end
  end
  mount ActionCable.server, at: '/cable'
end
