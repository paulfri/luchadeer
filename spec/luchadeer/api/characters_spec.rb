require 'spec_helper'

describe Luchadeer::API::Characters do
  let(:client) { Luchadeer::Client.new }

  describe '#games' do
    let(:character_id) { 1 }
    let(:character_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/character/3005-#{character_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, character_path).to_return(body: '{ }')
      client.character("#{character_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Character' do
      stub_request(:get, character_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.character("#{character_id}")).to be_instance_of Luchadeer::Character
    end

    it 'caches responses' do
      stub_request(:get, character_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.character("#{character_id}")
    end

  end
end
