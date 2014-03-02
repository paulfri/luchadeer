require 'luchadeer/resource'

module Luchadeer
  Location = Class.new(Resource) do
    const_set "SINGULAR", :location
    const_set "PLURAL",   :locations
  end

  module API
    module Locations
      RESOURCE_ID = 3035

      def location(id, refresh = false)
        fetch("location/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Location)
      end

      def locations(query = nil, refresh = false)
        search_resource('locations', query, refresh, Luchadeer::Location)
      end

    end
  end
end
