module V1
  class Users < Grape::API
    before { authenticate! }

    resources :users do
      desc 'GET /api/users'
      get '/' do
        present users: User.all
      end
    end
  end
end
