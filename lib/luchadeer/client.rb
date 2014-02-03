module Luchadeer
  class Client
    attr_accessor :api_key

    def initialize(opts = {})
      opts.each do |key, value|
        send(:"#{key}=", value)
      end
      
      yield self if block_given?
    end

    def user_agent
      @_user_agent ||= "Luchadeer #{Luchadeer::Version}"
    end

    def api_key?
      not api_key.nil?
    end
  end
end
