require 'luchadeer/resource'

module Luchadeer
  Video = Class.new(Resource) do
    const_set "SINGULAR", :video
    const_set "PLURAL",   :videos
  end

  module API
    module Videos
      RESOURCE_ID = 2300

      def video(id, refresh = false)
        fetch("video/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Video)
      end

      def videos(query = nil, refresh = false)
        search_resource('videos', query, refresh, Luchadeer::Video)
      end

    end
  end
end
