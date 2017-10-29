Rails.application.routes.draw do
  post 'upload', controller: :upload, action: :create
  get 'document', controller: :home, action: :index
  root 'home#index'
  get 'pick_address/:id', controller: :pick_address, action: :new, as: 'pick_address'
end