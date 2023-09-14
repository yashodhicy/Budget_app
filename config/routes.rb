Rails.application.routes.draw do  
  
  root to: "mains#index"
  devise_for :users

  resources :mains, only: %i[index]
  resources :users
  resources :categories, only: %i[index new create update show destroy]  do
    resources :expenses , only: %i[index new create destroy]
  end
  
  
end
