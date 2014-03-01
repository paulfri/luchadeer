require 'spec_helper'

describe Luchadeer::API::Concepts do

  it_behaves_like 'resources' do
    let(:name)  { :concept }
    let(:klass) { Luchadeer::Concept }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/concept/3015-#{id}) }
  end

end
