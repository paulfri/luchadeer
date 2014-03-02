require 'luchadeer/resource'

module Luchadeer
  Accessory = Class.new(Resource)

  module API
    module Accessories
      RESOURCE_ID = 3000

      def accessory(id, refresh = false)
        fetch("accessory/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Accessory)
      end

    end
  end
end
