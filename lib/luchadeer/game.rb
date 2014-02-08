require 'luchadeer/resource'

module Luchadeer
  class Game < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.game(id, refresh)
      end
    end

  end
end
