Rails.application.routes.draw do
  devise_for :users
  root to: 'top#index'
  get 'common/preview', to: 'common#preview'

  resources :profiles, only: %i[edit update]
  resources :notes do
    collection do
      match :index, via: %i[get post]
      match 'create_new', to: 'notes#create', via: 'post'
      get :add_favorite
      get :release_favorite
    end
  end
  resource :user_note_comment, only: %i[create update destroy]
end
