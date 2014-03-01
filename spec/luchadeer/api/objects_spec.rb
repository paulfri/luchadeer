require 'spec_helper'

describe Luchadeer::API::Objects do

  it_behaves_like 'resources' do
    let(:name)  { :object }
    let(:klass) { Luchadeer::Object }
    let(:rid)   { 3055 }
  end

end
