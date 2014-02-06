require 'hashie'

module Luchadeer
  class Game < Hashie::Mash

    class << self
      def find(id, refresh = false)
        Luchadeer.client.game(id, refresh)
      end
    end

  end
end
