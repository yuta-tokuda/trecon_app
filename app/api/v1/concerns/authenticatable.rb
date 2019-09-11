module V1
  module Concerns
    module Authenticatable
      extend ActiveSupport::Concern
      extend Grape::API::Helpers

      included do
        helpers do
          def authenticate!
            error!(I18n.t('api.errors.log_in_again'), 401) unless current_user
          end

          def current_user
            user = User.find_by(email: request.headers['Uid'])
            if Rails.env.development? || Rails.env.test?
              RequestToken.find_by(token: session[:access_token_test])&.user
            elsif user&.request_token&.token == request.headers['User-Token']
              user
            end
          end

          def session
            env['rack.session']
          end
        end
      end
    end
  end
end
