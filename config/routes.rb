Rails.application.routes.draw do
  concern :users do
    resources :users, only: [:create, :index] do
      member do
        patch :update_balance
        get :operations
      end
    end
  end

  namespace :v1 do
    concerns :users
  end
end
