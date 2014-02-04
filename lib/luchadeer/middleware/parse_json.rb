require 'faraday'
require 'json'

# adapted from the 'twitter' gem
# https://github.com/sferik/twitter/blob/88d7b19e295f27e1dcf970b979585fa9d3984cd6/lib/twitter/rest/response/parse_json.rb
module Luchadeer
  module Middleware
    class ParseJSON < Faraday::Response::Middleware
      WHITESPACE_REGEX = /\A^\s*$\z/

      def parse(body)
        case body
        when WHITESPACE_REGEX, nil
          nil
        else
          JSON.parse(body, symbolize_names: true)
        end
      end

      def on_complete(response)
        response.body = parse(response.body)
      end

    end
  end
end

Faraday::Response.register_middleware parse_json: Luchadeer::Middleware::ParseJSON
