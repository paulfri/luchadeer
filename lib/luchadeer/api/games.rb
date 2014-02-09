module Luchadeer
  module API
    module Games

      def game(id, refresh = false)
        Luchadeer::Game.new(fetch(game_path(id), refresh))
      end

    private

      def game_path(id)
        "game/3030-#{id}"
      end

    end
  end
end
