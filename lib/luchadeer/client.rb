module Luchadeer
  class Client
    attr_accessor :api_key
    API_BASE_URL = 'http://www.giantbomb.com/api'

    def initialize(opts = {})
      opts.each do |key, value|
        send(:"#{key}=", value)
      end
      
      yield self if block_given?
    end

    def user_agent
      "Luchadeer #{Luchadeer::VERSION}"
    end

    def api_key?
      not (api_key.nil? || api_key == '')
    end

    def get(path, params = {})
      request(:get, path, params)
    end

  private

    def connection
      @_connection ||= Faraday.new(API_BASE_URL, connection_options)
    end

    def connection_options
      {
        builder: middleware,
        headers: {
          accept: 'application/json',
          user_agent: user_agent,
        }
      }
    end

    def middleware
      Faraday::RackBuilder.new do |builder|
        # order is important
        builder.response :parse_api_error
        builder.response :parse_json
        builder.response :parse_http_error

        builder.adapter  :net_http
      end
    end

    def request(method, path, params = {})
      connection.send(method.to_sym, path, params.merge(default_params))
    # rescue => e
    #   raise Luchadeer::Error.new(e)
    end

    def default_params
      { format: 'json', api_key: api_key }
    end

  end
end
