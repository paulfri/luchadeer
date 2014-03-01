require 'spec_helper'

describe Luchadeer::API::Concepts do

  it_behaves_like 'resources' do
    let(:name)  { :concept }
    let(:klass) { Luchadeer::Concept }
    let(:rid)   { 3015 }
  end

end
