module V1
  class Authenticate < Grape::API
    params do
      requires :email,         type: String
      requires :password,      type: String
    end

    post '/sign_in' do
      user = User.find_by(email: params[:email])
      if user&.valid_password?(params[:password])
        request_token = user.create_request_token
        present token: request_token.token
      else
        error!(I18n.t('api.errors.authentication'), 401)
      end
    end
  end
end
