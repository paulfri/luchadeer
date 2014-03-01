require 'spec_helper'

describe Luchadeer::API::Videos do

  it_behaves_like 'resources' do
    let(:name)  { :video }
    let(:klass) { Luchadeer::Video }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/video/2300-#{id}) }
  end

end
