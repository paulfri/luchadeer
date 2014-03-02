require 'luchadeer/resource'

module Luchadeer
  Video = Class.new(Resource)

  module API
    module Videos
      RESOURCE_ID = 2300

      def video(id, refresh = false)
        fetch("video/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Video)
      end

    end
  end
end
