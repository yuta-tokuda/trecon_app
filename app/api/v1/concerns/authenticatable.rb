module V1
  module Concerns
    module Authenticatable
      extend ActiveSupport::Concern
      extend Grape::API::Helpers

      included do
        helpers do
          def authenticate!
            error!(I18n.t('api.errors.unauthorized'), 401) unless current_user
          end

          def current_user
            # 本来ヘッダの情報から取得するので注意。
            user = User.find_by(email: params[:uid])
            user if user&.request_token&.token == params[:Authorization]
          end
        end
      end
    end
  end
end
