require 'luchadeer/resource'

module Luchadeer
  class Concept < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.concept(id, refresh)
      end
    end

  end
end
