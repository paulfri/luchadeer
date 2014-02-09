require 'luchadeer'

describe Luchadeer::API do
  let(:client) { Luchadeer::Client.new }
  let(:key) { 'Chie' }
  let(:val) { 'Tomoe Gozen' }

  describe  '#cache' do
    context 'when value exists for key' do
      it 'returns the value for the given key' do
        client.cache = { key => val }
        expect(client.cache(key)).to eq val
      end
    end

    context 'when value does not exist for key' do
      context 'and no block is provided' do
        it 'raises KeyError' do
          expect { client.cache(key) }.to raise_error KeyError
        end
      end

      context 'and block is provided' do
        it 'assigns the result of the block to the given key' do
          client.cache(key) { val }
          expect(client.cache(key)).to eq val
        end
      end
    end

    context 'when refresh is true' do
      let(:new_val) { 'Suzuka Gongen' }

      it 'assigns the result of the block to the given key' do
        client.cache(key) { val }
        client.cache(key, true) { new_val }
        expect(client.cache(key)).to eq new_val
      end

      context 'and no block is provided' do
        it 'raises KeyError' do
          expect { client.cache(key, true) }.to raise_error KeyError
        end
      end
    end
  end

end
