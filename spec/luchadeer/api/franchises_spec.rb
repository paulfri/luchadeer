require 'spec_helper'

describe Luchadeer::API::Franchises do

  it_behaves_like 'resources' do
    let(:name)  { :franchise }
    let(:klass) { Luchadeer::Franchise }
  end

end
