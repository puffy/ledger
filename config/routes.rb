Rails.application.routes.draw do
  concern :users do
    resources :users, only: [:create, :index, :update]
  end

  namespace :v1 do
    concerns :users
  end
end
