GrapeSwaggerRails.options.app_name = 'TRECON_APP'
GrapeSwaggerRails.options.url = '/api/swagger_doc.json'

GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
