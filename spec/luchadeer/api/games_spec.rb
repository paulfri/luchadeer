require 'luchadeer'
require 'webmock/rspec'

describe Luchadeer::API::Games do
  let(:client) { Luchadeer::Client.new }

  describe '#games' do
    let(:game_id) { 1 }

    it 'caches responses' do
      stub_request(:get, %r(#{Luchadeer::Client::GIANT_BOMB}/game/3030-#{game_id}/))
        .to_return(body: "{ \"results\": { \"cache\": true } }")

      client.game("#{game_id}")
      expect(client.cache["game-#{game_id}"]).to eq cache: true
    end

  end
end
