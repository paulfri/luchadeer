require 'luchadeer/resource'

module Luchadeer
  class Location < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.location(id, refresh)
      end
    end

  end
end
