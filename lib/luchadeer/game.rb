require 'hashie'

module Luchadeer
  class Game < Hashie::Mash

    class << self
      def find(id)
        Luchadeer.client.game(id)
      end
    end

  end
end
