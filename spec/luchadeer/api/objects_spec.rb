require 'spec_helper'

describe Luchadeer::API::Objects do
  let(:client) { Luchadeer::Client.new }

  describe '#games' do
    let(:object_id) { 1 }
    let(:object_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/object/3055-#{object_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, object_path).to_return(body: '{ }')
      client.object("#{object_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Object' do
      stub_request(:get, object_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.object("#{object_id}")).to be_instance_of Luchadeer::Object
    end

    it 'caches responses' do
      stub_request(:get, object_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.object("#{object_id}")
    end

  end
end
