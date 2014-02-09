require 'spec_helper'

describe Luchadeer::Character do

  it 'is a resource' do
    expect(described_class.new).to be_a Luchadeer::Resource
  end

end
