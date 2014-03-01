require 'spec_helper'

describe Luchadeer::API::Games do

  it_behaves_like 'resources' do
    let(:name)  { :game }
    let(:klass) { Luchadeer::Game }
    let(:rid)   { 3030 }
  end

end
