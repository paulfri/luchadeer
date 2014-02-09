module Luchadeer
  module API
    module Characters

      def character(id, refresh = false)
        fetch(character_path(id), refresh, Luchadeer::Character)
      end

    private

      def character_path(id)
        "character/3005-#{id}"
      end

    end
  end
end
