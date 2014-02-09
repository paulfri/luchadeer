module Luchadeer
  module API
    module Games

      def game(id, refresh = false)
        fetch("game/3030-#{id}", refresh, Luchadeer::Game)
      end

    end
  end
end
