require 'spec_helper'

Luchadeer::API::RESOURCES.each do |resource|
  describe(resource) { it_behaves_like 'a resource' } # spec/support/shared_resource.rb
  describe(resource) { it_behaves_like 'a searchable resource' } # spec/support/shared_searchable.rb
end
