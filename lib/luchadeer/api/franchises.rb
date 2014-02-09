module Luchadeer
  module API
    module Franchises

      def franchise(id, refresh = false)
        fetch(franchise_path(id), refresh, Luchadeer::Franchise)
      end

    private

      def franchise_path(id)
        "franchise/3025-#{id}"
      end

    end
  end
end
