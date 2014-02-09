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
        stub_request(:get, search_path).to_return(body:
                            '{ "results": [
                                {"resource_type": "character"},
                                {"resource_type": "company"},
                                {"resource_type": "concept"},
                                {"resource_type": "franchise"},
                                {"resource_type": "game"},
                                {"resource_type": "location"},
                                {"resource_type": "object"},
                                {"resource_type": "person"},
                                {"resource_type": "video"}
                            ] }')
        described_class.new(query).fetch
      end

      its([0]) { should be_instance_of Luchadeer::Character }
      its([1]) { should be_instance_of Luchadeer::Company }
      its([2]) { should be_instance_of Luchadeer::Concept }
      its([3]) { should be_instance_of Luchadeer::Franchise }
      its([4]) { should be_instance_of Luchadeer::Game }
      its([5]) { should be_instance_of Luchadeer::Location }
      its([6]) { should be_instance_of Luchadeer::Object }
      its([7]) { should be_instance_of Luchadeer::Person }
      its([8]) { should be_instance_of Luchadeer::Video }
    end

    context 'when there are no results' do
      it 'returns an empty array' do
        stub_request(:get, search_path).to_return(body:
          '{ "results": [{ "resource_type": "banana"}] }')
        expect(described_class.new(query).fetch).to eq []
      end
    end

    context 'when the resource type isn\'t mapped' do
      it 'skips modeling the resource' do
        stub_request(:get, search_path).to_return(body: '{ "results": [] }')
        expect(described_class.new(query).fetch).to eq []
      end
    end
  end

end
