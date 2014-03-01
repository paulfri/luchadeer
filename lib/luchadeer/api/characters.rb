module Luchadeer
  module API
    module Characters
      RESOURCE_ID = 3005

      def character(id, refresh = false)
        fetch("character/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Character)
      end

    end
  end
end
