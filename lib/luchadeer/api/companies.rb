module Luchadeer
  module API
    module Companies
      RESOURCE_ID = 3010

      def company(id, refresh = false)
        fetch("company/#{RESOURCE_ID}-#{id}", refresh, Luchadeer::Company)
      end

    end
  end
end
