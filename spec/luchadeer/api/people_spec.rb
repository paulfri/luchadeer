require 'spec_helper'

describe Luchadeer::API::People do

  it_behaves_like 'resources' do
    let(:name)  { :person }
    let(:klass) { Luchadeer::Person }
    let(:rid)   { 3040 }
  end

end
