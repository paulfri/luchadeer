require 'luchadeer/resource'

module Luchadeer
  class Video < Resource

    class << self
      def find(id, refresh = false)
        Luchadeer.client.video(id, refresh)
      end
    end

  end
end
