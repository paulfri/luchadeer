shared_examples 'a resource' do
  let(:cname) { described_class.to_s }
  let(:name)  { cname[(cname.rindex('::')+2)..-1].downcase }

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

  describe '.search' do
    let(:path)   { %r(#{Luchadeer::Client::GIANT_BOMB}/search) }
    let(:query)  { 'chie' }
    let(:params) { { query: query, resources: "#{name}" } }

    it 'requests the right url' do
      stub = stub_request(:get, path).to_return(body: '{ "results": [] }')
      described_class.search(query)
      expect(stub).to have_been_requested
    end

    it 'includes the right parameters' do
      stub = stub_request(:get, path)
        .with(query: hash_including(params))
        .to_return(body: '{ "results": [] }')
      described_class.search(query)
      expect(stub).to have_been_requested
    end
  end

end
