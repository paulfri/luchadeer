module Luchadeer
  module API
    module Concepts
      RESOURCE_ID = 3015

      def concept(id, refresh = false)
        fetch("concept/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Concept)
      end

    end
  end
end
