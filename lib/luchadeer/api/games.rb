module Luchadeer
  module API
    module Games

      def game(id, refresh = false)
        cache_key = "game-#{id}"

        body = cache(cache_key, refresh) do
          get("game/3030-#{id}").body[:results]
        end

        Luchadeer::Game.new(body)
      end

    end
  end
end
