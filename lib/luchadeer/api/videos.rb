module Luchadeer
  module API
    module Videos

      def video(id, refresh = false)
        fetch("video/2300-#{id}", refresh, Luchadeer::Video)
      end

    end
  end
end
