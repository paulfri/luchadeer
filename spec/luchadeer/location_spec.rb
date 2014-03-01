require 'spec_helper'

describe Luchadeer::Location do

  it_behaves_like 'a resource'

  describe '.find' do
    let(:client) { Luchadeer::Client.new }

    before :each do
      Luchadeer.client = client
    end

    it 'forwards to Client#location with arguments' do
      expect(client).to receive(:location).with(1, true)
      described_class.find(1, true)
    end

    it 'forwards to Client#location with default refresh' do
      expect(client).to receive(:location).with(1, false)
      described_class.find(1)
    end
  end

end
