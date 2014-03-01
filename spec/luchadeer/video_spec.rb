require 'spec_helper'

describe Luchadeer::Video do

  it_behaves_like 'a resource'

  describe '.find' do
    let(:client) { Luchadeer::Client.new }

    before :each do
      Luchadeer.client = client
    end

    it 'forwards to Client#video with arguments' do
      expect(client).to receive(:video).with(1, true)
      described_class.find(1, true)
    end

    it 'forwards to Client#video with default refresh' do
      expect(client).to receive(:video).with(1, false)
      described_class.find(1)
    end
  end

end
