require 'spec_helper'

describe Luchadeer do
  let(:api_key) { 'VinnCo' }

  describe '.configure' do
    it 'returns a Luchadeer::Client' do
      expect(described_class.configure).to be_instance_of Luchadeer::Client
    end

    it 'passes opts hash to the new client' do
      hash = { api_key: api_key }

      expect(described_class.configure(hash).api_key).to eq api_key
    end

    it 'passes the given block to the new client' do
      proc = Proc.new { |c| c.api_key = api_key }

      expect(described_class.configure(&proc).api_key).to eq api_key
    end
  end

end
