module Authenticatable
  extend ActiveSupport::Concern
  extend Grape::API::Helpers

  included do
    helpers do
      def authenticate!
        error!('エラーが発生しました。ログインからやり直してください。') unless current_user
      end

      def current_user
        # 本来ヘッダの情報から取得するので注意。
        return nil unless params[:uid] && params[:Authorization]

        user = User.find_by(email: params[:uid])
        user if user.request_token.token == params[:Authorization]
      end
    end
  end
end
