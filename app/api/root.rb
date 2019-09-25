require 'grape_logging' if Rails.env.development?
require 'grape-swagger' if Rails.env.development?

class Root < Grape::API
  include GrapeSession::Ext::API if Rails.env.development?

  logger.formatter = GrapeLogging::Formatters::Json.new
  use GrapeLogging::Middleware::RequestLogger

  prefix 'api'
  format :json

  mount V1::Root
  if defined? GrapeSwaggerRails
    add_swagger_documentation(
      info: {
        title: 'TRECON_APP_API',
        description: 'API'
      }
    )
  end
end
