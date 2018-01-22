require 'uri'
require 'ratelimit'
require 'rest-client'
require 'json'

module FetchSupport
  # May throw an RestClient::InternalServerError if the remote server
  # returns a 403, 500 etc
  def fetch_json(url, headers = {})
    rate_limited(url) do
      raw = RestClient.get(url, headers)
      JSON.parse(raw)
    end
  end

  # May throw an RestClient::InternalServerError if the remote server
  # returns a 403, 500 etc
  def post_json(url, headers = {})
    rate_limited(url) do
      raw = RestClient.post(url, headers)
      JSON.parse(raw)
    end
  end


  def rate_limited(uri)
    host = URI.parse(uri).host
    args = {threshold: 1, interval: 1}

    ratelimit = Ratelimit.new("external-api")
    ratelimit.exec_within_threshold(host, args) do
      ratelimit.add(host)
      yield
    end
  end

  def expect_hash_match(a, b)
    # make all b keys a string
    new_b = {}
    b.each do |k, v|
      new_b[k.to_s] = v
    end

    expect(a.select { |k, v| new_b.keys.include?(k) }.sort).to eq(new_b.sort)
  end

  shared_examples "a web client" do
    shared_examples "a successful request" do
      let(:json) { fetch_json("#{ENV['HOST']}#{endpoint}") }
      let(:result) { json["result"] }

      it "is a succesful request" do
        expect(json["success"]).to eq true
        expect(json["time"]).to be >= (Time.now - 1.hour).to_i
        expect(json["time"]).to be <= (Time.now + 1.hour).to_i
        expect(json["result"]).to_not be_nil
      end
    end

    shared_examples "a failed request" do
      let(:json) do
        begin
          fetch_json("#{ENV['HOST']}#{endpoint}")
          raise "Did not expect the request to succeed"
        rescue RestClient::ExceptionWithResponse => e
          @code = e.response.code
          JSON.parse(e.response.body)
        end
      end
      let(:result) { json["result"] }

      it "is a failed request" do
        expect(json["success"]).to eq false
        expect(json["time"]).to be >= (Time.now - 1.hour).to_i
        expect(json["time"]).to be <= (Time.now + 1.hour).to_i
        expect(json["message"]).to eq message
        expect(json["result"]).to be_nil
        expect(@code).to eq code
      end
    end
  end
end
