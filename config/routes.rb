Rails.application.routes.draw do
  resources :users
  resources :categories do
    resources :expenses
  end

  root to: "user#index"
end
