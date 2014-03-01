shared_examples 'a resource' do |name|

  it 'is a Luchadeer::Resource' do
    expect(described_class.new).to be_a Luchadeer::Resource
  end

  describe '.find' do
    let(:client) { Luchadeer::Client.new }

    before :each do
      Luchadeer.client = client
    end

    it "forwards to Client##{name} with arguments" do
      expect(client).to receive(name).with(1, true)
      described_class.find(1, true)
    end

    it "forwards to Client##{name} with default refresh" do
      expect(client).to receive(name).with(1, false)
      described_class.find(1)
    end
  end

end
