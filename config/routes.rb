Rails.application.routes.draw do  
  devise_for :users

  resources :users
  resources :categories do
    resources :expenses
  end

  root to: "categories#index"
end
