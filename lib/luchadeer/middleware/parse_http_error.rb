require 'faraday'
require 'luchadeer/error'

module Luchadeer
  module Middleware
    class ParseHTTPError < Faraday::Response::Middleware

      def on_complete(response)
        klass = Luchadeer::Error.http_errors[response.status.to_i]

        if klass
          fail(klass.from_response(response))
        end
      end

    end
  end
end

Faraday::Response.register_middleware parse_http_error: Luchadeer::Middleware::ParseHTTPError
