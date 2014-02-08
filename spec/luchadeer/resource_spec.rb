require 'luchadeer'

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
      let(:arrayed) { hash.merge(arrayed: [ { test: "array" } ]) }
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

end
