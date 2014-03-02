require 'spec_helper'

RESOURCES = [Luchadeer::Accessory, Luchadeer::Character, Luchadeer::Company, Luchadeer::Concept,
  Luchadeer::Franchise, Luchadeer::Game, Luchadeer::Location, Luchadeer::Object,
  Luchadeer::Person, Luchadeer::Video]

RESOURCES.each do |resource|
  describe(resource) { it_behaves_like 'a resource' } # spec/support/shared_resource.rb
end

describe Luchadeer::Resource do
  let(:hash) { { first_name: 'Chie', last_name: 'Satonaka', age: 16 } }
  let(:resource) { described_class.new(hash) }

  describe '#initialize' do
    it 'generates ostruct accessors for its keys' do
      expect(resource.first_name).to eq hash[:first_name]
      expect(resource.last_name).to eq hash[:last_name]
      expect(resource.age).to eq hash[:age]
    end

    it 'returns nil for non-existent keys' do
      expect(resource.foo).to be_nil
    end

    context 'with nested hashes as values' do
      let(:nested) { hash.merge(nested: hash) }
      let(:nested_resource) { described_class.new(nested) }

      it 'recursively generates resource objects for nested hashes' do
        expect(nested_resource.nested).to be_a Luchadeer::Resource
      end
    end

    context 'with arrays as values' do
      let(:arrayed) { hash.merge(arrayed: [{ test: "array" }]) }
      let(:arrayed_resource) { described_class.new(arrayed) }

      it 'recursively generates resource objects inside nested arrays' do
        expect(arrayed_resource.arrayed[0]).to be_a Luchadeer::Resource
      end
    end
  end

  describe '#to_h' do
    it 'returns a hash' do
      expect(described_class.new(hash).to_h).to be_a Hash
    end

    it 'returns a hash representation of the object' do
      expect(described_class.new(hash).to_h).to eq hash
    end
  end

  describe '#detail' do
    before :each do
      Luchadeer.client = Luchadeer::Client.new
    end

    context 'when api_detail_url is present' do
      let(:url) { 'http://www.giantbomb.com/api/game-3030/1' }
      let(:resource) { described_class.new(api_detail_url: url) }

      it 'fetches details and returns the new object' do
        stub_request(:get, %r(#{url})).to_return(body: '{ "results": { "detailed?": true } }')
        expect(resource.detail.detailed?).to be_true
      end
    end

    context 'when api_detail_url is not present' do
      let(:resource) { described_class.new }

      it 'returns the original object' do
        expect(resource.detail).to eq resource
      end
    end
  end
end
