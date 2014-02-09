module Luchadeer
  module API
    module Characters

      def character(id, refresh = false)
        Luchadeer::Character.new(fetch(character_path(id), refresh))
      end

    private

      def character_path(id)
        "character/3005-#{id}"
      end

    end
  end
end
