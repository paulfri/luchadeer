require 'luchadeer/resource'

module Luchadeer
  Game = Class.new(Resource) do
    const_set "SINGULAR", :game
    const_set "PLURAL",   :games
  end

  module API
    module Games
      RESOURCE_ID = 3030

      def game(id, refresh = false)
        fetch("game/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Game)
      end

      def games(query = nil, refresh = false)
        search_resource('games', query, refresh, Luchadeer::Game)
      end

    end
  end
end
