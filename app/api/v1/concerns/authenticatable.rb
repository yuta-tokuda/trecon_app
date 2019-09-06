module V1
  module Concerns
    module Authenticatable
      extend ActiveSupport::Concern
      extend Grape::API::Helpers

      included do
        helpers do
          params :authentication do
            requires :uid, type: String
            requires :user_token, type: String
          end

          def authenticate!
            error!(I18n.t('api.errors.log_in_again'), 401) unless current_user
          end

          def current_user
            # 本来ヘッダの情報から取得するので注意。
            user = User.find_by(email: params[:uid])
            user if user&.request_token&.token == params[:user_token]
          end
        end
      end
    end
  end
end
