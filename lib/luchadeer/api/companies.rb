module Luchadeer
  module API
    module Companies

      def company(id, refresh = false)
        fetch("company/3010-#{id}", refresh, Luchadeer::Company)
      end

    end
  end
end
