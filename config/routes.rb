Rails.application.routes.draw do
  devise_for :users
  root to: 'top#index'

  resources :profiles, only: %i[edit update]

  resources :notes do
    collection do
      match :index, via: %i[get post]
      match 'create_new', to: 'notes#create', via: 'post'
      get :preview
      get :add_favorite
      get :release_favorite
    end
  end
end
