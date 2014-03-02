require 'luchadeer/client'
require 'luchadeer/search'

module Luchadeer
  class << self
    def configure(opts = {}, &blk)
      Luchadeer.client = Luchadeer::Client.new(opts, &blk)
    end

    def client
      Thread.current[:luchadeer_client]
    end

    def client=(new_client)
      Thread.current[:luchadeer_client] = new_client
    end

    def search(*args, &blk)
      Luchadeer::Search.new(*args, &blk).fetch
    end
  end
end
