Rails.application.routes.draw do  
  
  root to: "mains#index"
  devise_for :users

  resources :mains, only: %i[index]
  resources :users
  resources :categories do
    resources :expenses
  end
  
  
end
