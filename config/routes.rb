Rails.application.routes.draw do
  concern :users do
    resources :users, only: [:create, :index] do
      patch :update_balance, on: :member
    end
  end

  namespace :v1 do
    concerns :users
  end
end
