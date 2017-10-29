Rails.application.routes.draw do
  resources :uploads do
    member do
      get 'pick_columns'
    end
  end
  root 'uploads#new'
end
