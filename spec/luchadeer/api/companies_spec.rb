require 'spec_helper'

describe Luchadeer::API::Characters do
  let(:client) { Luchadeer::Client.new }

  describe '#companies' do
    let(:company_id) { 1 }
    let(:company_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/company/3010-#{company_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, company_path).to_return(body: '{ }')
      client.company("#{company_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Company' do
      stub_request(:get, company_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.company("#{company_id}")).to be_instance_of Luchadeer::Company
    end

    it 'caches responses' do
      stub_request(:get, company_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.company("#{company_id}")
    end

  end
end
