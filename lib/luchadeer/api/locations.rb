module Luchadeer
  module API
    module Locations

      def location(id, refresh = false)
        fetch("location/3035-#{id}", refresh, Luchadeer::Location)
      end

    end
  end
end
