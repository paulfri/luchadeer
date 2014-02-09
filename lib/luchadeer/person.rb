require 'luchadeer/resource'

module Luchadeer
  class Person < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.person(id, refresh)
      end
    end

  end
end
