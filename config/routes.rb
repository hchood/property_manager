PropertyManager::Application.routes.draw do
  root to: 'buildings#index'

  resources :buildings, only: [:index, :new, :create]
end
