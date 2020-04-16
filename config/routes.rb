Rails.application.routes.draw do
  root :to => 'users#index'
  get '/destroy_all', to: 'users#destroy_all'
  get '/get_scores', to: 'users#get_scores'
end