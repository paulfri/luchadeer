require 'spec_helper'

describe Luchadeer::API::Accessories do

  it_behaves_like 'resources' do
    let(:klass) { Luchadeer::Accessory }
  end

end
