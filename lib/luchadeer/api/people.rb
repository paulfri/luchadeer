module Luchadeer
  module API
    module People

      def person(id, refresh = false)
        fetch("person/3040-#{id}", refresh, Luchadeer::Person)
      end

    end
  end
end
