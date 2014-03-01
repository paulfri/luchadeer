require 'spec_helper'

describe Luchadeer::API::People do

  it_behaves_like 'resources' do
    let(:name)  { :person }
    let(:klass) { Luchadeer::Person }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/person/3040-#{id}) }
  end

end
