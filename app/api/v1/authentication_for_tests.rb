module V1
  class AuthenticationForTests < Grape::API
    use ActionDispatch::Session::CookieStore

    desc 'POST /api/v1/sign_in_for_test'
    params do
      requires :user_id, type: Integer
    end

    post '/sign_in_for_test' do
      user = User.find(params[:user_id])
      request_token = user.create_request_token
      session[:access_token_test] = request_token.token
      present session[:access_token_test]
    end
  end
end
