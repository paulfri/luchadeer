require 'luchadeer'

describe Luchadeer::Client do
  let(:api_key) { 'luchadeer' }
  let(:client) { described_class.new(api_key: api_key) }

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

  describe '#get' do
    let(:url) { %r(http://laika.io) }

    it 'makes a GET request' do
      stub = stub_request(:get, url).to_return(body: '{ "asdf": "asdf" }')
      client.get("http://laika.io")

      expect(stub).to have_been_requested
    end

    it 'adds default parameters' do
      stub = stub_request(:get, url).with(format: 'json', api_key: api_key)
        .to_return(body: '{ "asdf": "asdf" }')

      client.get("http://laika.io")
      expect(stub).to have_been_requested
    end
  end

end
