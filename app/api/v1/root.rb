module V1
  class Root < Grape::API
    include Concerns::Authenticatable
    version 'v1'

    rescue_from ActiveRecord::RecordNotFound do
      error!('404 NotFound', 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      messages = e.record.errors.to_hash(true)
      messages.each do |k, v|
        messages[k] = v.join("\n")
      end
      error!({ errors: messages }, 400)
    end

    mount V1::Authenticate
    mount V1::AuthenticationForTests
    mount V1::Notes
    mount V1::Users
  end
end
