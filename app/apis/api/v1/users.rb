module API
  module V1
    class Users < Grape::API
      helpers do
        def authenticate!
          error!('エラーが発生しました。ログインからやり直してください。') unless current_user
        end

        def current_user
          # 本来ヘッダの情報を取得するが、パラメータから取得すると仮定して
          return nil unless params[:uid] && params[:Authorization]

          user = User.find_by(email: params[:uid])
          user if user.request_token.token == params[:Authorization]
        end
      end

      resources :users do
        get '/' do
          authenticate!
          render User.all
        end

        post '/sign_in' do
          @user = User.find_by(email: params[:email])
          if @user&.valid_password?(params[:password])
            request_token = @user.create_request_token
            render token: request_token.token
          else
            render error: 'メールアドレスもしくはパスワードが違います。'
          end
        end
      end
    end
  end
end
