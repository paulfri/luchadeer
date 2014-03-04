require 'faraday'
require 'luchadeer/api'
require 'luchadeer/error'
require 'luchadeer/version'
require 'luchadeer/middleware/follow_redirects'
require 'luchadeer/middleware/parse_json'
require 'luchadeer/middleware/parse_http_error'
require 'luchadeer/middleware/parse_api_error'

module Luchadeer
  class Client
    GIANT_BOMB = 'http://www.giantbomb.com/api'

    include Luchadeer::API

    attr_accessor :api_key

    def initialize(opts = {})
      @api_key = opts[:api_key] if opts[:api_key]
      yield self if block_given?
    end

    def api_key?
      not (api_key.nil? || api_key == '')
    end

    def get(path, params = {})
      request(:get, path, params)
    end

  private

    def connection
      @_connection ||= Faraday.new(GIANT_BOMB, headers: headers) do |f|
        f.response :parse_api_error
        f.response :parse_json
        f.response :parse_http_error
        f.response :follow_redirects

        f.adapter  :net_http
      end
    end

    def headers
      { accept: 'application/json', user_agent: "Luchadeer v#{Luchadeer::VERSION}" }
    end

    def request(method, path, params = {})
      connection.send(method.to_sym, path, params.merge(default_params))
    rescue Faraday::Error => e
      raise Luchadeer::Error.new e
    end

    def default_params
      { format: 'json', api_key: api_key }
    end

  end
end
