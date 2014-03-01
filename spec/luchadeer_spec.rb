require 'spec_helper'

describe Luchadeer do
  let(:api_key) { 'VinnCo' }

  describe '.configure' do
    it 'returns a Luchadeer::Client' do
      expect(described_class.configure).to be_a Luchadeer::Client
    end

    it 'passes opts hash to the new client' do
      expect(described_class.configure(api_key: api_key).api_key).to eq api_key
    end

    it 'passes the given block to the new client' do
      proc = ->(c) { c.api_key = api_key }
      expect(described_class.configure(&proc).api_key).to eq api_key
    end
  end

end
