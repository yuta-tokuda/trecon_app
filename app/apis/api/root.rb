require 'grape_logging'
require 'grape-swagger'

module API
  class Root < Grape::API
    logger.formatter = GrapeLogging::Formatters::Json.new
    use GrapeLogging::Middleware::RequestLogger

    prefix 'api'
    format :json

    mount V1::Root
  end
end
