Rails.application.routes.draw do
  resources :uploads do
    member do
      get 'pick_columns'
      get 'geocode_process'
      get 'report'
    end
  end
  root 'uploads#new'
end
