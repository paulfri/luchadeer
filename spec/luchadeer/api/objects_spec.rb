require 'spec_helper'

describe Luchadeer::API::Objects do

  it_behaves_like 'resources' do
    let(:name)  { :object }
    let(:klass) { Luchadeer::Object }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/object/3055-#{id}) }
  end

end
