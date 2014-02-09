module Luchadeer
  module API
    module Games

      def game(id, refresh = false)
        game = cache(game_path(id), refresh) do
          get(game_path(id)).body[:results]
        end

        Luchadeer::Game.new(game)
      end

    private

      def game_path(id)
        "game/3030-#{id}"
      end

    end
  end
end
