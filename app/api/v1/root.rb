module V1
  class Root < Grape::API
    include Concerns::Authenticatable
  
    version 'v1'

    mount V1::Authenticate
    mount V1::Users
  end
end
