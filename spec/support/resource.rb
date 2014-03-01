shared_examples 'a resource' do

  it 'is a Luchadeer::Resource' do
    expect(described_class.new).to be_a Luchadeer::Resource
  end

end
