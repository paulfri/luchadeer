module Luchadeer
  module API
    module Franchises

      def franchise(id, refresh = false)
        cache_key = "franchise-#{id}"

        body = cache(cache_key, refresh) do
          get("franchise/3025-#{id}").body[:results]
        end

        Luchadeer::Franchise.new(body)
      end

    end
  end
end
