module Luchadeer
  module API
    module Games

      def game(id, refresh = false)
        cache_key = "game-#{id}"
        @cache.delete(cache_key) if refresh

        body = @cache.fetch(cache_key) do
          @cache[cache_key] = get("game/3030-#{id}/").body[:results]
        end

        Luchadeer::Game.new(body)
      end

    end
  end
end
