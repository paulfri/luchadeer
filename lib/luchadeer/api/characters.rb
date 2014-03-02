require 'luchadeer/resource'

module Luchadeer
  Character = Class.new(Resource) do
    const_set "SINGULAR", :character
    const_set "PLURAL",   :characters
  end

  module API
    module Characters
      RESOURCE_ID = 3005

      def character(id, refresh = false)
        fetch("character/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Character)
      end

    end
  end
end
