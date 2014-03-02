require 'luchadeer/resource'

module Luchadeer
  Company = Class.new(Resource) do
    const_set "SINGULAR", :company
    const_set "PLURAL",   :companies
  end

  module API
    module Companies
      RESOURCE_ID = 3010

      def company(id, refresh = false)
        fetch("company/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Company)
      end

    end
  end
end
