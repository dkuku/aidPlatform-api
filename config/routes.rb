Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/tasks/:task_id/conversations/',:type => 'task', to: 'conversations#index'
      post '/tasks/:task_id/conversations/messages', to: 'messages#create'
      get '/tasks/:task_id/conversations/messages', to: 'conversations#index'
      devise_scope :user do
        post 	'sign_up', to: 'registrations#create'
        post 	'sign_in', to: 'sessions#create'
		    delete 	'log_out', to: 'sessions#destroy'
      end

      resources :tasks, only: [:index, :show, :create, :update, :destroy] do
        resources :conversations, only: [:show, :create, :destroy], :type => 'task'
      end
      resources :conversations, only: [:index, :create, :destroy], :type => 'all'
    end
  end
  mount ActionCable.server, at: '/stats'
end
