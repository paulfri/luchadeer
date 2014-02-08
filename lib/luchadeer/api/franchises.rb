module Luchadeer
  module API
    module Franchises

      def franchise(id, refresh = false)
        cache_key = "franchise-#{id}"
        @cache.delete(cache_key) if refresh

        body = @cache.fetch(cache_key) do
          @cache[cache_key] = get("franchise/3025-#{id}").body[:results]
        end

        Luchadeer::Franchise.new(body)
      end

    end
  end
end
