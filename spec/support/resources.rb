# Invoke this shared example group with three defined variables:
# name,  the singular name of the resource, as a symbol
# klass, the Luchadeer resource class that maps to the resource
# path,  the API path that the method should hit (for stubbing)

shared_examples 'resources' do

  let(:client) { Luchadeer::Client.new }

  describe "#{name}" do
    let(:id) { 1 }

    it 'requests the right url' do
      stub = stub_request(:get, path).to_return(body: '{ }')
      client.send(name, "#{id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Character' do
      stub_request(:get, path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.send(name, "#{id}")).to be_instance_of klass
    end

    it 'caches responses' do
      stub_request(:get, path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.send(name, "#{id}")
    end
  end

end
