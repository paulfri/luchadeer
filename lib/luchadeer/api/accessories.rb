require 'luchadeer/resource'

module Luchadeer
  Accessory = Class.new(Resource) do
    const_set "SINGULAR", :accessory
    const_set "PLURAL",   :accessories
  end

  module API
    module Accessories
      RESOURCE_ID = 3000

      def accessory(id, refresh = false)
        fetch("accessory/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Accessory)
      end

      def accessories(query = nil, refresh = false)
        query = "?filter=name:#{query}" unless query.nil? or query.length < 1
        fetch("accessories#{query}", refresh, Luchadeer::Accessory)
      end

    end
  end
end
