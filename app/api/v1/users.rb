module V1
  class Users < Grape::API
    include Concerns::Authenticatable
    before { authenticate! }

    resources :users do
      desc 'GET /api/users'
      params do
        use :authentication
      end

      get '/' do
        render User.all
      end
    end
  end
end
