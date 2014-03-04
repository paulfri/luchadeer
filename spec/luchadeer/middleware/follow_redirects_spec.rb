require 'spec_helper'

describe Luchadeer::Middleware::FollowRedirects do
  let(:response) { 'yay!' }

  # adapted from:
  # https://github.com/lostisland/faraday_middleware/blob/5a19d04a77650405a97ea0abc6152d23134b624e/spec/follow_redirects_spec.rb
  [301, 302, 303, 307].each do |status|
    it "follows redirects for responses with status #{status}" do
      connection = Faraday.new do |f|
        f.use described_class
        f.adapter :test do |stub|
          stub.get('/redirect') { [status, { 'Location' => '/found' }, ''] }
          stub.get('/found')    { [200, { 'Content-Type' => 'text/plain' }, response] }
        end
      end

      expect(connection.get('/redirect').body).to eq response
    end
  end

  it 'raises a RedirectLimitReached after three redirects' do
    connection = Faraday.new do |f|
      f.use described_class
      f.adapter :test do |stub|
        stub.get('/')          { [301, {'Location' => '/redirect'}, ''] }
        stub.get('/redirect')  { [301, {'Location' => '/redirect2'}, ''] }
        stub.get('/redirect2') { [301, {'Location' => '/redirect3'}, ''] }
        stub.get('/redirect3') { [301, {'Location' => '/found'}, ''] }
        stub.get('/found')     { [200, {'Content-Type' => 'text/plain'}, 'fin'] }
      end
    end

    expect { connection.get('/') }.to raise_error(Luchadeer::Error::RedirectLimitReached)
  end

end
