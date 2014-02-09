module Luchadeer
  module API
    module Characters

      def character(id, refresh = false)
        fetch("character/3005-#{id}", refresh, Luchadeer::Character)
      end

    end
  end
end
