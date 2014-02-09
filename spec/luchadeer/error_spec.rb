require 'spec_helper'

describe Luchadeer::Error do

  describe '.api_errors' do
    let(:ok)         { Luchadeer::Error::Codes::OK }
    let(:error_code) { Luchadeer::Error::Codes::INVALID_API_KEY }
    let(:exception)  { Luchadeer::Error::InvalidAPIKey }

    it 'returns a hash' do
      expect(described_class.api_errors).to respond_to :[]
    end

    it 'maps API error codes to exceptions' do
      expect(described_class.api_errors[error_code]).to eq exception
    end

    it 'does not map "OK" to an exception' do
      expect(described_class.api_errors[ok]).to be_nil
    end
  end

  describe '.http_errors' do
    let(:error_code) { 404 }
    let(:exception)  { Luchadeer::Error::NotFound }

    it 'returns a hash' do
      expect(described_class.http_errors).to respond_to :[]
    end

    it 'maps HTTP status codes to exceptions' do
      expect(described_class.http_errors[error_code]).to eq exception
    end

    it 'does not map 200' do
      expect(described_class.http_errors[200]).to be_nil
    end
  end

  describe '#initialize' do
    let(:message) { 'testing' }
    let(:error) { described_class.new(message) }

    it 'is raiseable' do
      expect(error).to be_a StandardError
    end

    it 'constructs with message and status' do
      expect(error.message).to eq message
    end
  end

end
