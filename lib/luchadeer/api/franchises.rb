module Luchadeer
  module API
    module Franchises

      def franchise(id, refresh = false)
        fetch("franchise/3025-#{id}", refresh, Luchadeer::Franchise)
      end

    end
  end
end
