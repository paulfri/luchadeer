require 'luchadeer'

describe Luchadeer::Client do
  let(:client) { described_class.new }

  describe '#initialize' do
    it 'yields itself for configuration' do
      expect { |b| described_class.new(&b) }.to yield_control.once
    end
  end

  describe '#user_agent' do
    it 'identifies the library' do
      expect(client.user_agent).to eq "Luchadeer #{Luchadeer::VERSION}"
    end
  end

  describe '#api_key?' do
    context 'when API key is present' do
      it 'returns true' do
        client.api_key = 'key'
        expect(client.api_key?).to be_true
      end
    end

    context 'when API key is not present' do
      it 'returns false' do
        client.api_key = ''
        expect(client.api_key?).to be_false
      end
    end
  end 

end
