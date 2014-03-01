require 'spec_helper'

describe Luchadeer::API::Locations do

  it_behaves_like 'resources' do
    let(:name)  { :location }
    let(:klass) { Luchadeer::Location }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/location/3035-#{id}) }
  end

end
