require 'faraday'
require 'luchadeer/error'

module Luchadeer
  module Middleware
    class ParseAPIError < Faraday::Response::Middleware

      def on_complete(response)
        klass = Luchadeer::Error.api_errors[response.body[:status_code]]

        fail(klass.new(response.body[:error])) if klass
      end

    end
  end
end

Faraday::Response.register_middleware parse_api_error: Luchadeer::Middleware::ParseAPIError
