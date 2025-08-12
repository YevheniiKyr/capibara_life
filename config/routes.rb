Rails.application.routes.draw do
  # post '/capibaras', to: 'capibaras#create'
  # get '/capibaras', to: 'capibaras#show'
  # put '/capibaras/:id', to: 'capibaras#update'
  # delete '/capibaras/:id', to: 'capibaras#destroy'

  # post '/login', to: 'users#login'
  # post '/users', to: 'users#create'
  # get '/capibaras', to: 'capibaras#index'
  #
  #  # constraints AuthMiddleware do
  #   # resources :capibaras
  #   post '/capibaras', to: 'capibaras#create'
  #   delete '/capibaras/:id', to: 'capibaras#destroy'
  #   put '/capibaras/:id', to: 'capibaras#update'
  #
  #   get '/users', to: 'users#index'
  #   # resources :users, only: %i[create index]
  #   resources :connections
  #   resources :connection_types
  #
  #   get '/auth/check', to: 'users#check'
  #   delete 'capibaras', to: 'capibaras#deleteAll'
   # end






  resources :capibaras
  resources :users, only: %i[create index]
  resources :connections
  resources :connection_types
  post '/login', to: 'users#login'
  get '/auth/check', to: 'users#check'
  Rails.application.routes.draw do
  resources :capibaras
  resources :users, only: %i[create index]
  resources :connections
  resources :connection_types

  post '/login', to: 'users#login'
  get '/auth/check', to: 'users#check'
  delete 'capibaras', to: 'capibaras#delete_all'
end


end
