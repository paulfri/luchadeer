require 'luchadeer/resource'

module Luchadeer
  class Company < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.company(id, refresh)
      end
    end

  end
end
