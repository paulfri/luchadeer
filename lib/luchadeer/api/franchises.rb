module Luchadeer
  module API
    module Franchises

      def franchise(id, refresh = false)
        Luchadeer::Franchise.new(fetch(franchise_path(id), refresh))
      end

    private

      def franchise_path(id)
        "franchise/3025-#{id}"
      end

    end
  end
end
