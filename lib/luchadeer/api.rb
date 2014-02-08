require 'luchadeer/api/games'
require 'luchadeer/api/franchises'

module Luchadeer
  module API
    API_MODULES = [
      Luchadeer::API::Games,
      Luchadeer::API::Franchises,
    ]

    API_MODULES.each do |mod|
      include mod
    end
  end
end
