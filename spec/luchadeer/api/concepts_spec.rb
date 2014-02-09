require 'spec_helper'

describe Luchadeer::API::Concepts do
  let(:client) { Luchadeer::Client.new }

  describe '#concepts' do
    let(:concept_id) { 1 }
    let(:concept_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/concept/3015-#{concept_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, concept_path).to_return(body: '{ }')
      client.concept("#{concept_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Concept' do
      stub_request(:get, concept_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.concept("#{concept_id}")).to be_instance_of Luchadeer::Concept
    end

    it 'caches responses' do
      stub_request(:get, concept_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.concept("#{concept_id}")
    end

  end
end
