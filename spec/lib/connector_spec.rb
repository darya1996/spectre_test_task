require 'rails_helper'

RSpec.describe Connector do
  url = "http://example.com"

  let(:response) { { code: 200, headers: {}, body: "{}" } }
  let(:options) { { url: "example.com", payload: {} } }

  describe ".get" do
    it "calls .request method with GET" do
      expect(described_class)
        .to receive(:request)
        .with(hash_including(method: :get, url: url))
        .and_return(response)

      expect(described_class.get(url, options)).to eq(response)
    end
  end

  describe ".post" do
    it "calls .request method with POST" do
      expect(described_class)
        .to receive(:request)
        .with(hash_including(method: :post, url: url))
        .and_return(response)

      expect(described_class.post(url, options)).to eq(response)
    end
  end

  describe ".put" do
    it "calls .request method with PUT" do
      expect(described_class)
        .to receive(:request)
        .with(hash_including(method: :put, url: url))
        .and_return(response)

      expect(described_class.put(url, options)).to eq(response)
    end
  end

  describe ".delete" do
    it "calls .request method with DELETE" do
      expect(described_class)
        .to receive(:request)
        .with(hash_including(method: :delete, url: url))
        .and_return(response)

      expect(described_class.delete(url, options)).to eq(response)
    end
  end
end
