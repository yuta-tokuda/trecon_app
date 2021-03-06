module V1
  class Authenticate < Grape::API
    params do
      requires :email,         type: String
      requires :password,      type: String
    end

    desc 'GET /api/v1/sign_in'
    get '/sign_in' do
      user = User.find_by(email: params[:email])
      if user&.valid_password?(params[:password])
        request_token = user.create_request_token
        present token: request_token.token
      else
        error!(I18n.t('api.errors.authentication'), 401)
      end
    end

    desc 'GET /api/v1/sign_out'
    get '/sign_out' do
      request_token = RequestToken.find_by(token: request.headers['User-Token'])
      request_token&.destroy
      present message: I18n.t('devise.sessions.signed_out')
    end
  end
end
