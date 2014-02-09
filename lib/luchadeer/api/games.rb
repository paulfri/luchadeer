module Luchadeer
  module API
    module Games

      def game(id, refresh = false)
        fetch(game_path(id), refresh, Luchadeer::Game)
      end

    private

      def game_path(id)
        "game/3030-#{id}"
      end

    end
  end
end
