require 'spec_helper'

describe Luchadeer::API::Characters do

  it_behaves_like 'resources' do
    let(:name)  { :character }
    let(:klass) { Luchadeer::Character }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/character/3005-#{id}) }
  end

end
