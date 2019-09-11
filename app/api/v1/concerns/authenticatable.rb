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
            request.headers['User-Token'] = test_session[:access_token_test] if !Rails.env.production? && test_session[:access_token_test].present?
            RequestToken.find_by(token: request.headers['User-Token'])&.user
          end

          def test_session
            env['rack.session']
          end
        end
      end
    end
  end
end
