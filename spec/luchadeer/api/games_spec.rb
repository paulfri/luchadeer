require 'spec_helper'

describe Luchadeer::API::Games do

  it_behaves_like 'resources' do
    let(:name)  { :game }
    let(:klass) { Luchadeer::Game }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/game/3030-#{id}) }
  end

end
