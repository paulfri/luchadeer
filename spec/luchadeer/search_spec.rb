require 'spec_helper'

describe Luchadeer::Search do
  let(:query) { 'Chie Satonaka' }
  let(:search_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/search) }

  describe '#initialize' do
    it 'instantiates with a search query' do
      expect(described_class.new(query).query).to eq query
    end
  end

  describe '#fetch' do
    before :each do
      Luchadeer.client = Luchadeer::Client.new
    end

    it 'queries the Giant Bomb search API' do
      stub = stub_request(:get, search_path).to_return(body: '{ "results": [] }')

      described_class.new(query).fetch
      expect(stub).to have_been_requested
    end

    describe 'generates the proper class based on the result type' do
      subject do
        stub = stub_request(:get, search_path).to_return(body:
                            '{ "results": [
                                {"resource_type" : "game"},
                                {"resource_type" : "franchise"}
                            ] }')
        described_class.new(query).fetch
      end

      its([0]) { should be_instance_of Luchadeer::Game }
      its([1]) { should be_instance_of Luchadeer::Franchise }
      # TODO: add mappings here as the resources get added
    end

    context 'when there are no results' do
      it 'returns an empty array' do
        stub = stub_request(:get, search_path).to_return(body:
          '{ "results": [{ "resource_type": "banana"}] }')
        expect(described_class.new(query).fetch).to eq []
      end
    end

    context 'when the resource type isn\'t mapped' do
      it 'skips modeling the resource' do
        stub = stub_request(:get, search_path).to_return(body: '{ "results": [] }')
        expect(described_class.new(query).fetch).to eq []
      end
    end
  end

end
