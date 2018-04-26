Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/', to: 'welcome#index'
  post '/', to: 'welcome#login'

  get '/dashboard', to: 'dashboard#index'
  get '/logout', to: 'dashboard#logout'

  get '/items', to: 'item_web#index'
  post '/items', to: 'item_web#create'
  
  scope '/api', :defaults => {format: :json} do
    scope '/v1' do
      scope '/auth' do
        post 'login', to: 'auth#login'
        post 'signup', to: 'auth#create'
      end

      resources :item, except: [:new, :edit] do
        post 'buy', to: 'item#buy'
      end

      get '/users', to: 'users#index'
      get '/random/user', to: 'users#random'

      get 'me', to: 'me#show'
      put 'me', to: 'me#update'
      delete 'me', to: 'me#destroy'

      scope '/user' do
        get 'friends', to: 'friend#index'
        get 'friend/:friend_id', to: 'friend#show'
        post 'friend', to: 'friend#create'
        delete 'friend/:friend_id', to: 'friend#destroy'

        get 'top', to: 'friend#top'

        get 'matches', to: 'match#index'
        get 'match/:match_id', to: 'match#show'
        post 'match', to: 'match#create'
        put 'match_board/:match_id', to: 'match#setup'
        put 'match/:match_id', to: 'match#update'

        get 'items', to: 'user_item#index'
        put 'item/:id', to: 'user_item#use_item'

        get 'chats', to: 'chat#index'

        get 'messages/:friendship_id', to: 'message#show'
        post 'message', to: 'message#create'
      end
    end
  end
end
