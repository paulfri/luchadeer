require 'spec_helper'

describe Luchadeer::API::Locations do

  it_behaves_like 'resources' do
    let(:name)  { :location }
    let(:klass) { Luchadeer::Location }
  end

end
