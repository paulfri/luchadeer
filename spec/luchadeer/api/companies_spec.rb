require 'spec_helper'

describe Luchadeer::API::Companies do

  it_behaves_like 'resources' do
    let(:name)  { :company }
    let(:klass) { Luchadeer::Company }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/company/3010-#{id}) }
  end

end
