module Luchadeer
  module API
    module Games
      RESOURCE_ID = 3030

      def game(id, refresh = false)
        fetch("game/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Game)
      end

    end
  end
end
