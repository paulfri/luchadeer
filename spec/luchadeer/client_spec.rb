require 'spec_helper'

describe Luchadeer::Client do
  let(:api_key) { 'luchadeer' }
  let(:client) { described_class.new(api_key: api_key) }

  describe '#initialize' do
    it 'yields itself for configuration' do
      expect { |b| described_class.new(&b) }.to yield_control.once
    end
  end

  describe '#get' do
    let(:url) { %r(http://laika.io) }
    let(:empty_body) { '{ }' }

    it 'makes a GET request' do
      stub = stub_request(:get, url).to_return(body: empty_body)
      client.get("http://laika.io")

      expect(stub).to have_been_requested
    end

    it 'adds default parameters' do
      stub = stub_request(:get, url).with(format: 'json', api_key: api_key)
        .to_return(body: empty_body)

      client.get("http://laika.io")
      expect(stub).to have_been_requested
    end

    it 'catches and reraises Faraday errors' do
      allow(client).to receive(:connection).and_raise Faraday::Error
      expect { client.get('path') }.to raise_error Luchadeer::Error
    end
  end

  describe '#connection' do
    describe 'user agent header' do
      it 'identifies the library' do
        expect(client.send(:connection).headers[:user_agent]).to eq "Luchadeer v#{Luchadeer::VERSION}"
      end
    end

    describe 'middleware stack' do
      it 'includes all custom middleware and the Net::HTTP adapter' do
        expect(client.send(:connection).builder.handlers).to include \
          Luchadeer::Middleware::ParseAPIError,
          Luchadeer::Middleware::ParseJSON,
          Luchadeer::Middleware::ParseHTTPError,
          Luchadeer::Middleware::FollowRedirects,
          Faraday::Adapter::NetHttp
      end
    end
  end

end
