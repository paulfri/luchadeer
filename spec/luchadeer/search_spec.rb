require 'spec_helper'

describe Luchadeer::Search do
  let(:query) { 'Chie Satonaka' }
  let(:search_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/search) }
  let(:empty_body) { { body: '{ "results": [] }' } }

  describe '#initialize' do
    it 'instantiates with no arguments' do
      expect(described_class.new).to be_instance_of described_class
    end

    it 'instantiates with an options hash' do
      expect(described_class.new(query: query).query).to eq query
    end

    it 'yields self if block given' do
      expect { |b| described_class.new(&b) }.to yield_control
    end
  end

  describe '#fetch' do
    let(:search) { described_class.new(query: query).fetch }

    before :each do
      Luchadeer.client = Luchadeer::Client.new
    end

    it 'queries the Giant Bomb search API' do
      stub = stub_request(:get, search_path).to_return(empty_body)

      search
      expect(stub).to have_been_requested
    end

    describe 'request parameters' do
      it 'includes supplied parameters' do
        stub = stub_request(:get, "http://www.giantbomb.com/api/search")
          .with(query: { api_key: nil, format: 'json', query: query, limit: 10 })
          .to_return(empty_body)

        described_class.new(query: query, limit: 10).fetch
        expect(stub).to have_been_requested
      end

      it 'omits nil parameters' do
        stub = stub_request(:get, "http://www.giantbomb.com/api/search")
          .with(query: { api_key: nil, format: 'json', query: query })
          .to_return(empty_body)

        described_class.new(query: query, limit: nil, page: nil).fetch
        expect(stub).to have_been_requested
      end
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
        search
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
        expect(search).to be_empty
      end
    end

    context 'when the resource type isn\'t mapped' do
      it 'skips modeling the resource' do
        stub_request(:get, search_path).to_return(empty_body)
        expect(search).to be_empty
      end
    end
  end

end
