require 'spec_helper'

describe Luchadeer::Person do

  it_behaves_like 'a resource'

  describe '.find' do
    let(:client) { Luchadeer::Client.new }

    before :each do
      Luchadeer.client = client
    end

    it 'forwards to Client#person with arguments' do
      expect(client).to receive(:person).with(1, true)
      described_class.find(1, true)
    end

    it 'forwards to Client#person with default refresh' do
      expect(client).to receive(:person).with(1, false)
      described_class.find(1)
    end
  end

end
