module Luchadeer
  module API
    module Search

      def search(*args, &blk)
        Luchadeer::Search.new(*args, &blk).fetch
      end

    end
  end
end
