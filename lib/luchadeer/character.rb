require 'luchadeer/resource'

module Luchadeer
  class Character < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.character(id, refresh)
      end
    end

  end
end
