require 'spec_helper'

describe Luchadeer::Concept do

  it_behaves_like 'a resource'

  describe '.find' do
    let(:client) { Luchadeer::Client.new }

    before :each do
      Luchadeer.client = client
    end

    it 'forwards to Client#concept with arguments' do
      expect(client).to receive(:concept).with(1, true)
      described_class.find(1, true)
    end

    it 'forwards to Client#concept with default refresh' do
      expect(client).to receive(:concept).with(1, false)
      described_class.find(1)
    end
  end

end
