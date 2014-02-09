require 'spec_helper'

describe Luchadeer::API::Games do
  let(:client) { Luchadeer::Client.new }

  describe '#games' do
    let(:game_id) { 1 }
    let(:game_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/game/3030-#{game_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, game_path).to_return(body: '{ }')
      client.game("#{game_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Game' do
      stub_request(:get, game_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.game("#{game_id}")).to be_instance_of Luchadeer::Game
    end

    it 'caches responses' do
      stub_request(:get, game_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.game("#{game_id}")
    end

  end
end
