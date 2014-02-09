require 'spec_helper'

describe Luchadeer::API::Locations do
  let(:client) { Luchadeer::Client.new }

  describe '#Locations' do
    let(:location_id) { 1 }
    let(:location_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/location/3035-#{location_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, location_path).to_return(body: '{ }')
      client.location("#{location_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Location' do
      stub_request(:get, location_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.location("#{location_id}")).to be_instance_of Luchadeer::Location
    end

    it 'caches responses' do
      stub_request(:get, location_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.location("#{location_id}")
    end

  end
end
