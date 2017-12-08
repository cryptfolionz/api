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

    expect(a.select { |k, v| new_b.keys.include?(k) }).to eq(new_b)
  end
end
