module Luchadeer
  class Error < StandardError

    # Used for bespoke status codes returned in the response body
    module Code
      OK                     = 1
      INVALID_API_KEY        = 100
      OBJECT_NOT_FOUND       = 101
      URL_FORMAT_ERROR       = 102
      JSON_CALLBACK_REQUIRED = 103
      FILTER_ERROR           = 104
      SUBSCRIBER_ONLY        = 105
    end

    # Used for HTTP status codes
    def self.http_errors
      {
        400 => Luchadeer::Error::BadRequest,
        401 => Luchadeer::Error::Unauthorized,
        403 => Luchadeer::Error::Forbidden,
        404 => Luchadeer::Error::NotFound,
        408 => Luchadeer::Error::RequestTimeout,
        500 => Luchadeer::Error::InternalServerError,
        502 => Luchadeer::Error::BadGateway,
        503 => Luchadeer::Error::ServiceUnavailable,
        504 => Luchadeer::Error::GatewayTimeout,
      }
    end

    def self.from_response(response)
      new('', response.status)
    end

    def initialize(message = '', status = nil)
      super(message)
      @status = status
    end

  private

    class BadRequest < Luchadeer::Error; end
    class Unauthorized < Luchadeer::Error; end
    class Forbidden < Luchadeer::Error; end
    class NotFound < Luchadeer::Error; end
    class RequestTimeout < Luchadeer::Error; end
    class InternalServerError < Luchadeer::Error; end
    class BadGateway < Luchadeer::Error; end
    class ServiceUnavailable < Luchadeer::Error; end
    class GatewayTimeout < Luchadeer::Error; end
  end
end
