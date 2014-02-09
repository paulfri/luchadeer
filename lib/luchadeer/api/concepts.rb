module Luchadeer
  module API
    module Concepts

      def concept(id, refresh = false)
        fetch("concept/3015-#{id}", refresh, Luchadeer::Concept)
      end

    end
  end
end
