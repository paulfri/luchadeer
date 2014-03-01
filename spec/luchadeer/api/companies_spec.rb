require 'spec_helper'

describe Luchadeer::API::Companies do

  it_behaves_like 'resources' do
    let(:name)  { :company }
    let(:klass) { Luchadeer::Company }
    let(:rid)   { 3010 }
  end

end
