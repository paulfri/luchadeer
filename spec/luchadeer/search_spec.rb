require 'spec_helper'

describe Luchadeer::Search do
  let(:query) { 'Chie Satonaka' }
  let(:limit) { 10 }
  let(:page)  { 1 }
  let(:sort)  { 'name' }
  let(:search) { described_class.new }
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

  describe '#query' do
    it 'sets the query' do
      expect(search.query(query).query).to eq query
    end

    it 'returns the search instance' do
      expect(search.query(query)).to eq search
    end
  end

  describe '#limit' do
    it 'sets the limit' do
      expect(search.limit(limit).limit).to eq limit
    end

    it 'returns the search instance' do
      expect(search.limit(limit)).to eq search
    end
  end

  describe '#page' do
    it 'sets the page' do
      expect(search.page(page).page).to eq page
    end

    it 'returns the search instance' do
      expect(search.page(page)).to eq search
    end
  end

  describe '#sort' do
    it 'sets the sort to the given parameter and defaults to ascending' do
      expect(search.sort(sort).sort).to eq "#{sort}:asc"
    end

    it 'allows changing the sort direction' do
      expect(search.sort(sort, :desc).sort).to eq "#{sort}:desc"
    end

    it 'allows changing the sort with a string' do
      expect(search.sort(sort, 'desc').sort).to eq "#{sort}:desc"
    end

    it 'returns the search instance' do
      expect(search.sort(sort)).to eq search
    end
  end

  describe '#resources' do
    context 'when called with a valid string' do
      it 'sets resources to the given string' do
        expect(search.resources('person,location').resources).to eq 'person,location'
      end
    end

    context 'when called with an invalid string' do
      it 'raises ArgumentError' do
        expect { search.resources('naoto,yosuke,kanji').resources }.to raise_error ArgumentError
      end
    end

    context 'when called with class' do
      it 'maps the class to a string' do
        expect(search.resources(Luchadeer::Person).resources).to eq 'person'
      end
    end

    context 'when called with array' do
      context 'of valid' do
        context 'strings' do
          it 'sets resources to comma-delimited string of given strings' do
            expect(search.resources(['person', 'location']).resources).to eq 'person,location'
          end
        end

        context 'classes' do
          it 'maps the classes to strings' do
            expect(search.resources([Luchadeer::Person, Luchadeer::Location]).resources).to eq 'person,location'
          end
        end
      end

      context 'of invalid' do
        context 'strings' do
          it 'raises ArgumentError' do
            expect { search.resources ['person', 'naoto'] }.to raise_error ArgumentError
          end
        end

        context 'classes' do
          it 'raises ArgumentError' do
            expect { search.resources [String, BasicObject, Luchadeer::Search] }.to raise_error ArgumentError
          end
        end
      end
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
        params = { query: query, limit: 10, page: 1, resources: 'video', sort: 'name:asc' }

        stub = stub_request(:get, "http://www.giantbomb.com/api/search")
          .with(query: { api_key: nil, format: 'json' }.merge(params))
          .to_return(empty_body)

        described_class.new(params).fetch
        expect(stub).to have_been_requested
      end

      it 'omits nil parameters' do
        stub = stub_request(:get, 'http://www.giantbomb.com/api/search')
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

      it { expect(subject[0]).to be_instance_of Luchadeer::Character }
      it { expect(subject[1]).to be_instance_of Luchadeer::Company }
      it { expect(subject[2]).to be_instance_of Luchadeer::Concept }
      it { expect(subject[3]).to be_instance_of Luchadeer::Franchise }
      it { expect(subject[4]).to be_instance_of Luchadeer::Game }
      it { expect(subject[5]).to be_instance_of Luchadeer::Location }
      it { expect(subject[6]).to be_instance_of Luchadeer::Object }
      it { expect(subject[7]).to be_instance_of Luchadeer::Person }
      it { expect(subject[8]).to be_instance_of Luchadeer::Video }
    end

    context 'when the resource type isn\'t mapped' do
      it 'skips modeling the resource' do
        stub_request(:get, search_path).to_return(body:
          '{ "results": [{ "resource_type": "banana"}] }')
        expect(search).to be_empty
      end
    end

    context 'when there are no results' do
      it 'returns an empty array' do
        stub_request(:get, search_path).to_return(empty_body)
        expect(search).to be_empty
      end
    end
  end

end
