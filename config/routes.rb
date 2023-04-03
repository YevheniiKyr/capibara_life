Rails.application.routes.draw do
  # post '/capibaras', to: 'capibaras#create'
  #get '/capibaras', to: 'capibaras#show'
  #put '/capibaras/:id', to: 'capibaras#update'
  #delete '/capibaras/:id', to: 'capibaras#destroy'
  resources :capibaras
  resources :users, only: %i[create index]
  post '/login', to: 'users#login'
end
