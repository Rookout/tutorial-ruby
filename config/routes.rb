Rails.application.routes.draw do
  get '/tasks' => 'tasks#index'
  get '/tasks/active' => 'tasks#index'
  get '/tasks/completed' => 'tasks#index'
  post '/tasks/toggle_complete_all' => 'tasks#toggle_complete_all'
  post '/tasks/clear_completed' => 'tasks#clear_completed'
  post '/' => 'tasks#create'
  put '/tasks/:id' => 'tasks#update'
  delete '/tasks/remove_all' => 'tasks#remove_all'
  delete '/tasks/:id' => 'tasks#destroy'
  root 'tasks#index'

  resources :tasks
end
