module Luchadeer
  module API
    module Franchises
      RESOURCE_ID = 3025

      def franchise(id, refresh = false)
        fetch("franchise/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Franchise)
      end

    end
  end
end
