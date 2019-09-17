require 'grape_logging' unless Rails.env.production?
require 'grape-swagger' unless Rails.env.production?

class Root < Grape::API
  include GrapeSession::Ext::API unless Rails.env.production?

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
