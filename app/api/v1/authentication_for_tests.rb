module V1
  class AuthenticationForTests < Grape::API
    desc 'GET /api/v1/sign_in_for_test'
    params do
      requires :user_id, type: Integer
    end

    get '/sign_in_for_test' do
      user = User.find(params[:user_id])
      request_token = user.create_request_token
      session[:access_token_test] = request_token.token
      present message: I18n.t('devise.sessions.signed_in')
    end

    desc 'GET /api/v1/sign_out_for_test'
    get '/sign_out_for_test' do
      token = RequestToken.find_by(token: session[:access_token_test])
      token.destroy
      session[:access_token_test] = nil
      present message: I18n.t('devise.sessions.signed_out')
    end
  end
end
