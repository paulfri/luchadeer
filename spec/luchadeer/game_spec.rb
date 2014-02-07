require 'luchadeer'
require 'webmock'

describe Luchadeer::Game do

  describe '.find' do
    let(:client) { Luchadeer::Client.new }

    before :each do
      Luchadeer.client = client
    end

    it 'forwards to Client#game with id and defaults refresh to false' do
      expect(client).to receive(:game).with(1, false)
      described_class.find(1)
    end

    it 'forwards to Client#game' do
      expect(client).to receive(:game).with(1, true)
      described_class.find(1, true)
    end
  end

end
