module Luchadeer
  module API
    module Games

      def game(id)
        Luchadeer::Game.new get("game/3030-#{id}/").body[:results]
      end

    end
  end
end
