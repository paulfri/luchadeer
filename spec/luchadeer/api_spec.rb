require 'spec_helper'

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

    describe '#fetch' do
      it 'uses the cache' do
        stub_request(:get, %r(http://www.giantbomb.com/api/game-3030/21373))
          .to_return(body:'{ }')

        client.should_receive :cache
        client.fetch('game-3030/21373')
      end

      context 'with a single result' do
        before :each do
          stub_request(:get, %r(http://www.giantbomb.com/api/game-3030/21373))
            .to_return(body:'{ "results": { "name": "Narukami" } }')
        end

        it 'returns an object of the provided class' do
          expect(client.fetch('game-3030/21373', false, Luchadeer::Game))
            .to be_instance_of Luchadeer::Game
        end

        it 'defaults to Luchadeer::Resource' do
          expect(client.fetch('game-3030/21373')).to be_instance_of Luchadeer::Resource
        end
      end

      context 'with an array of results' do
        before :each do
          stub_request(:get, %r(http://www.giantbomb.com/api/game-3030/21373))
            .to_return(body:'{ "results": [{ "name": "Narukami" }, { "name": "Hanamura"}] }')
        end

        it 'returns an array' do
          expect(client.fetch('game-3030/21373')).to be_instance_of Array
        end

        it 'returns objects of the provided class' do
          expect(client.fetch('game-3030/21373', false, Luchadeer::Game)[0])
            .to be_instance_of Luchadeer::Game
          expect(client.fetch('game-3030/21373', false, Luchadeer::Game)[1])
            .to be_instance_of Luchadeer::Game
        end
      end

      context 'with no results' do
        it 'returns nil' do
          stub_request(:get, %r(http://www.giantbomb.com/api/game-3030/21373))
            .to_return(body:'{ }')

          expect(client.fetch('game-3030/21373')).to be_nil
        end
      end
    end
  end

end
