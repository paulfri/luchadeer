require 'luchadeer/resource'

module Luchadeer
  Franchise = Class.new(Resource) do
    const_set "SINGULAR", :franchise
    const_set "PLURAL",   :franchises
  end

  module API
    module Franchises
      RESOURCE_ID = 3025

      def franchise(id, refresh = false)
        fetch("franchise/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Franchise)
      end

    end
  end
end
