require 'luchadeer/resource'

module Luchadeer
  class Franchise < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.franchise(id, refresh)
      end
    end

  end
end
