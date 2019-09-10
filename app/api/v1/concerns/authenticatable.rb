module V1
  module Concerns
    module Authenticatable
      extend ActiveSupport::Concern
      extend Grape::API::Helpers

      def self.headers
        {
          uid: {
            description: '',
            required: true
          },
          user_token: {
            description: '',
            required: true
          }
        }
      end

      included do
        helpers do
          def authenticate!
            error!(I18n.t('api.errors.log_in_again'), 401) unless current_user
          end

          def current_user
            user = User.find_by(email: request.headers['Uid'])
            user if user&.request_token&.token == request.headers['User-Token']
          end
        end
      end
    end
  end
end
