require 'spec_helper'

describe Luchadeer::API::People do
  let(:client) { Luchadeer::Client.new }

  describe '#games' do
    let(:person_id) { 1 }
    let(:person_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/person/3040-#{person_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, person_path).to_return(body: '{ }')
      client.person("#{person_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Object' do
      stub_request(:get, person_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.person("#{person_id}")).to be_instance_of Luchadeer::Person
    end

    it 'caches responses' do
      stub_request(:get, person_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.person("#{person_id}")
    end

  end
end
