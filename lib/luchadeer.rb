require 'luchadeer/version'

require 'luchadeer/api'
require 'luchadeer/client'
require 'luchadeer/error'
require 'luchadeer/search'

require 'luchadeer/company'
require 'luchadeer/concept'
require 'luchadeer/franchise'
require 'luchadeer/game'
require 'luchadeer/location'
require 'luchadeer/object'
require 'luchadeer/person'
require 'luchadeer/video'

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
  end
end
