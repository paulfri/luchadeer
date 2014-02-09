require 'spec_helper'

describe Luchadeer::API::Videos do
  let(:client) { Luchadeer::Client.new }

  describe '#games' do
    let(:video_id) { 1 }
    let(:video_path) { %r(#{Luchadeer::Client::GIANT_BOMB}/video/2300-#{video_id}) }

    it 'requests the right url' do
      stub = stub_request(:get, video_path).to_return(body: '{ }')
      client.video("#{video_id}")
      expect(stub).to have_been_requested
    end

    it 'returns a Luchadeer::Object' do
      stub_request(:get, video_path).to_return(body: '{ "results": { "key": "value"}}')
      expect(client.video("#{video_id}")).to be_instance_of Luchadeer::Video
    end

    it 'caches responses' do
      stub_request(:get, video_path).to_return(body: '{ }')
      expect(client).to receive :cache
      client.video("#{video_id}")
    end

  end
end
