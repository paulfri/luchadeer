module Luchadeer
  class Error < StandardError

    module Codes
      OK                     = 1
      INVALID_API_KEY        = 100
      OBJECT_NOT_FOUND       = 101
      URL_FORMAT_ERROR       = 102
      JSON_CALLBACK_REQUIRED = 103 # should be only apply to 'jsonp' format
      FILTER_ERROR           = 104
      SUBSCRIBER_ONLY        = 105
    end

    # Used for bespoke status codes returned in the response body
    def self.api_errors
      {
        Codes::INVALID_API_KEY => Luchadeer::Error::InvalidAPIKey,
        Codes::OBJECT_NOT_FOUND => Luchadeer::Error::ObjectNotFound,
        Codes::URL_FORMAT_ERROR => Luchadeer::Error::URLFormatError,
        Codes::JSON_CALLBACK_REQUIRED => Luchadeer::Error::JSONCallbackRequired,
        Codes::FILTER_ERROR => Luchadeer::Error::FilterError,
        Codes::SUBSCRIBER_ONLY => Luchadeer::Error::SubscriberOnly
      }
    end

    # Used for HTTP status codes
    def self.http_errors
      {
        400 => Luchadeer::Error::BadRequest,
        401 => Luchadeer::Error::Unauthorized,        # unconfirmed
        403 => Luchadeer::Error::Forbidden,           # unconfirmed
        404 => Luchadeer::Error::NotFound,
        408 => Luchadeer::Error::RequestTimeout,      # unconfirmed
        500 => Luchadeer::Error::InternalServerError,
        502 => Luchadeer::Error::BadGateway,          # unconfirmed
        503 => Luchadeer::Error::ServiceUnavailable,  # unconfirmed
        504 => Luchadeer::Error::GatewayTimeout       # unconfirmed
      }
    end

  private

    class InvalidAPIKey < Luchadeer::Error; end
    class ObjectNotFound < Luchadeer::Error; end
    class URLFormatError < Luchadeer::Error; end
    class JSONCallbackRequired < Luchadeer::Error; end
    class FilterError < Luchadeer::Error; end
    class SubscriberOnly < Luchadeer::Error; end

    class RedirectLimitReached < Luchadeer::Error; end

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
