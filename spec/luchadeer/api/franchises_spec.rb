require 'spec_helper'

describe Luchadeer::API::Franchises do
  let(:client) { Luchadeer::Client.new }

  describe '#games' do
    let(:franchise_id) { 1 }
    let(:franchise_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/franchise/3025-#{franchise_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, franchise_path).to_return(body: '{ }')
      client.franchise("#{franchise_id}")
      expect(stub).to have_been_requested
    end

    it 'caches responses' do
      stub_request(:get, franchise_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.franchise("#{franchise_id}")
    end

  end
end
