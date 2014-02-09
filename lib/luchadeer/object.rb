require 'luchadeer/resource'

module Luchadeer
  class Object < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.object(id, refresh)
      end
    end

  end
end
