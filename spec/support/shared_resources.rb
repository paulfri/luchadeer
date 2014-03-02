# Invoke this shared example group with a let statement passed in a block:
# let(:described_class) { ... }, the Luchadeer resource class that maps to the resource

shared_examples 'a searchable resource' do
  let(:client) { Luchadeer::Client.new }

  describe 'find method' do
    let(:find) { described_class::SINGULAR }
    let(:id)   { 14850 }
    let(:path) { %r(#{Luchadeer::Client::GIANT_BOMB}/#{find}/#{described_class::RESOURCE_ID}-#{id}) }

    it 'requests the right url' do
      stub = stub_request(:get, path).to_return(body: '{ }')
      client.send(find, "#{id}")
      expect(stub).to have_been_requested
    end

    it 'returns the proper type of resource' do
      stub_request(:get, path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.send(find, "#{id}")).to be_instance_of described_class
    end

    it 'caches responses' do
      stub_request(:get, path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.send(find, "#{id}")
    end
  end

  describe 'search method' do
    let(:search) { described_class::PLURAL }
    let(:query) { 'chie' }
    let(:path)  { %r(#{Luchadeer::Client::GIANT_BOMB}/#{search}) }

    context 'when invoked with a query' do
      it 'requests the right url' do
        stub = stub_request(:get, path)
          .with(query: hash_including(filter: "name:#{query}"))
          .to_return(body: '{ }')
        client.send(search, query)
        expect(stub).to have_been_requested
      end
    end

    context 'when invoked without a query' do
      it 'requests the right url' do
        stub = stub_request(:get, path).to_return(body: '{ }')
        client.send(search)
        expect(stub).to have_been_requested
      end
    end

    it 'returns the proper type of resource' do
      stub_request(:get, path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.send(search, query)).to be_instance_of described_class
    end

    it 'caches responses' do
      stub_request(:get, path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.send(search, query)
    end
  end

end
