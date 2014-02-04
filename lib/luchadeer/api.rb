require 'luchadeer/api/games'

module Luchadeer
  module API
    API_MODULES = [
      Luchadeer::API::Games
    ]

    API_MODULES.each do |mod|
      include mod
    end
  end
end
