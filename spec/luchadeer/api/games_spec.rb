require 'spec_helper'

describe Luchadeer::API::Games do

  it_behaves_like 'resources' do
    let(:name)  { :game }
    let(:klass) { Luchadeer::Game }
  end

end
