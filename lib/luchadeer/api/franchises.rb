module Luchadeer
  module API
    module Franchises

      def franchise(id, refresh = false)
        franchise = cache(franchise_path(id), refresh) do
          get(franchise_path(id)).body[:results]
        end

        Luchadeer::Franchise.new(franchise)
      end

    private

      def franchise_path(id)
        "franchise/3025-#{id}"
      end

    end
  end
end
