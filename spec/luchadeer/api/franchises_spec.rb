require 'spec_helper'

describe Luchadeer::API::Franchises do

  it_behaves_like 'resources' do
    let(:name)  { :franchise }
    let(:klass) { Luchadeer::Franchise }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/franchise/3025-#{id}) }
  end

end
