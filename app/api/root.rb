require 'grape_logging'
require 'grape-swagger'

class Root < Grape::API
  logger.formatter = GrapeLogging::Formatters::Json.new
  use GrapeLogging::Middleware::RequestLogger

  prefix 'api'
  format :json

  mount Authenticate
  mount Users
  add_swagger_documentation(
    info: {
      title: 'TRECON_APP_API',
      description: 'API'
    }
  )
end
