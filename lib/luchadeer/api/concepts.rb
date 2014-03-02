require 'luchadeer/resource'

module Luchadeer
  Concept = Class.new(Resource) do
    const_set "SINGULAR", :concept
    const_set "PLURAL",   :concepts
  end

  module API
    module Concepts
      RESOURCE_ID = 3015

      def concept(id, refresh = false)
        fetch("concept/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Concept)
      end

      def concepts(query = nil, refresh = false)
        search_resource('concepts', query, refresh, Luchadeer::Concept)
      end

    end
  end
end
