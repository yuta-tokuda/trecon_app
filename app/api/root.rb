require 'grape_logging'
require 'grape-swagger'

class Root < Grape::API
  logger.formatter = GrapeLogging::Formatters::Json.new
  use GrapeLogging::Middleware::RequestLogger

  prefix 'api'
  format :json

  mount V1::Root
  add_swagger_documentation(
    info: {
      title: 'TRECON_APP_API',
      description: 'API'
    }
  )
end
