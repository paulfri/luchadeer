module Luchadeer
  class Error < StandardError

    module Code
      INVALID_API_KEY        = 100
      OBJECT_NOT_FOUND       = 101
      URL_FORMAT_ERROR       = 102
      JSON_CALLBACK_REQUIRED = 103
      FILTER_ERROR           = 104
      SUBSCRIBER_ONLY        = 105
    end

    def from_response(response)
      message, code = parse_error(response.body)
      new(message, response.response_headers, code)
    end

    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end

  private

    def parse_error(body)
      if body.nil?
        ['', nil]
      elsif body[:error] && body[:status_code]
        [body[:error], body[:status_code]]
      end
    end

    class RequestTimeout < StandardError; end
  end
end
