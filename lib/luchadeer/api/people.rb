require 'luchadeer/resource'

module Luchadeer
  Person = Class.new(Resource)

  module API
    module People
      RESOURCE_ID = 3040

      def person(id, refresh = false)
        fetch("person/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Person)
      end

    end
  end
end
