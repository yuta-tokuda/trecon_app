Rails.application.routes.draw do
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/docs'
  devise_for :users
  root to: 'top#index'
  get 'common/preview', to: 'common#preview'
  get 'user_note_comments/create_comment', to: 'user_note_comments#create_comment'
  get 'user_note_comments/update_comment', to: 'user_note_comments#update_comment'
  get 'user_note_comments/destroy_comment', to: 'user_note_comments#destroy_comment'
  get 'notification', to: 'notifications#confirm'

  resources :profiles, only: %i[edit update]
  resources :notes do
    collection do
      match :index, via: %i[get post]
      match 'create_new', to: 'notes#create', via: 'post'
      get :add_favorite
      get :release_favorite
    end
  end
end
