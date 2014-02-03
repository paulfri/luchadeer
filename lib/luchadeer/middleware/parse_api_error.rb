require 'faraday'
require 'luchadeer/error'

module Luchadeer
  module Middleware
    class ParseAPIError < Faraday::Response::Middleware

      def on_complete(response)
        # raise "#{response.body.inspect}"
        # raise "status #{response.body['status_code']} // error #{response.body['error']}"
        if response.body['status_code'] != Luchadeer::Error::Code::OK
          raise Luchadeer::Error.new(response.body[:error])
        end
      end

    end
  end
end

Faraday::Response.register_middleware parse_api_error: Luchadeer::Middleware::ParseAPIError
