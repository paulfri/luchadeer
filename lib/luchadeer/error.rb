module Luchadeer
  class Error < StandardError

    # http://www.giantbomb.com/api/documentation#toc-0-0
    module Codes
      OK                     = 1
      INVALID_API_KEY        = 100
      OBJECT_NOT_FOUND       = 101
      URL_FORMAT_ERROR       = 102
      FILTER_ERROR           = 104
      SUBSCRIBER_ONLY        = 105
    end

    # Used for bespoke status codes returned in the response body
    def self.api_errors
      {
        Codes::INVALID_API_KEY  => Luchadeer::Error::InvalidAPIKey,
        Codes::OBJECT_NOT_FOUND => Luchadeer::Error::NotFound,
        Codes::URL_FORMAT_ERROR => Luchadeer::Error::URLFormatError,
        Codes::FILTER_ERROR     => Luchadeer::Error::FilterError,
        Codes::SUBSCRIBER_ONLY  => Luchadeer::Error::SubscriberOnly
      }
    end

    # Used for HTTP status codes
    def self.http_errors
      {
        400 => Luchadeer::Error::BadRequest,
        404 => Luchadeer::Error::NotFound,
        500 => Luchadeer::Error::InternalServerError,
        502 => Luchadeer::Error::InternalServerError, # unconfirmed
        503 => Luchadeer::Error::InternalServerError, # unconfirmed
        504 => Luchadeer::Error::InternalServerError, # unconfirmed
      }
    end

    %w[RedirectLimitReached RequestTimeout InvalidAPIKey URLFormatError FilterError
    SubscriberOnly BadRequest NotFound InternalServerError ].each do |e|
      const_set e, Class.new(Luchadeer::Error)
    end

  end
end
