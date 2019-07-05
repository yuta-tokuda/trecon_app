Rails.application.routes.draw do
  devise_for :users
  root to: 'top#index'

  resources :profiles, only: %i[edit update]

  resources :notes do
    collection do
      get :preview
      get :add_favorite
      get :release_favorite
    end
  end
end
