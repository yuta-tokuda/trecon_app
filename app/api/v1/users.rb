module V1
  class Users < Grape::API
    before { authenticate! }

    params do
      # 本来ヘッダの情報から取得するので注意
      requires :uid,           type: String
      requires :Authorization, type: String
    end

    resources :users do
      desc 'GET /api/users'
      get '/' do
        render User.all
      end
    end
  end
end
