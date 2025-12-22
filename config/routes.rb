Rails.application.routes.draw do
  get "dashboard/index"
  devise_for :users

  resources :expense_reports do
    member do
      post :submit
      post :approve
      post :reject
    end
  end

  root "expense_reports#index"
end
