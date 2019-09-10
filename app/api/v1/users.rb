module V1
  class Users < Grape::API
    before { authenticate! }

    resources :users do
      desc 'GET /api/users', headers: Concerns::Authenticatable.headers
      get '/' do
        present users: User.all
      end
    end
  end
end
