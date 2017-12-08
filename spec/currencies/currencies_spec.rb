require 'spec_helper'

describe "/currencies" do
  include FetchSupport

  it "returns a list of currencies" do
    json = fetch_json("#{ENV["HOST"]}/api/currencies")

    expect(json["success"]).to eq true
    expect(json["time"]).to be > 0

    expect(json["result"]["currencies"].length).to eq json["result"]["count"]

    currency = json["result"]["currencies"].first

    expect(currency.keys.sort).to eq [
        "id",
        "code",
        "title",
        "created_at",
        "updated_at",
        "is_cryptocurrency",
        "is_fiat",
        "is_ethereum_token",
        "ethereum_contract_address",
        "source",
      ].sort

    expected = {
      "id":    1,
      "code":  "btc",
      "title": "Bitcoin",
      "is_cryptocurrency": true,
      "is_fiat": false,
      "is_ethereum_token": false,
      "ethereum_contract_address": nil,
      "source": nil,
    }

    expect_hash_match(currency, expected)
  end
end
