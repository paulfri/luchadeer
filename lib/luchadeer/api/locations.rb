require 'luchadeer/resource'

module Luchadeer
  Location = Class.new(Resource)

  module API
    module Locations
      RESOURCE_ID = 3035

      def location(id, refresh = false)
        fetch("location/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Location)
      end

    end
  end
end
