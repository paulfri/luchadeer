module Luchadeer
  module API
    module Objects

      def object(id, refresh = false)
        fetch("object/3055-#{id}", refresh, Luchadeer::Object)
      end

    end
  end
end
