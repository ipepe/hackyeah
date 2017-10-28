Rails.application.routes.draw do
  post 'upload', controller: :upload, action: :create
  get 'document', controller: :home, action: :index
  root 'home#index'
end
