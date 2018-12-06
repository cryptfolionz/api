require 'spec_helper'

describe "/currencies" do
  include FetchSupport

  let(:currency_keys) { [
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
  ] }

  let(:bitcoin_parameters) {{
    "code":              "btc",
    "title":             "Bitcoin",
    "is_cryptocurrency": true,
    "is_fiat":           false,
    "is_ethereum_token": false,
    "ethereum_contract_address": nil,
  }}

  let(:usdollar_parameters) {{
    "code":              "usd",
    "title":             "United States dollar",
    "is_cryptocurrency": false,
    "is_fiat":           true,
    "is_ethereum_token": false,
    "ethereum_contract_address": nil,
  }}

  let(:augur_parameters) {{
    "code":              "rep",
    "title":             "Augur",
    "is_cryptocurrency": false,
    "is_fiat":           false,
    "is_ethereum_token": true,
    "ethereum_contract_address": "0xe94327d07fc17907b4db788e5adf2ed424addff6",
  }}

  it_behaves_like "a web client" do
    describe "#index" do
      let(:endpoint) { "/api/currencies" }

      it_behaves_like "a successful request" do
        it "returns a list of currencies" do
          expect(result["currencies"].length).to eq result["count"]

          currency = result["currencies"].first
          expect(currency.keys.sort).to eq currency_keys.sort

          bitcoin = result["currencies"].select { |currency| currency["code"] == "btc" }.first
          expect_hash_match(bitcoin, bitcoin_parameters)
        end
      end
    end

    describe "#show" do
      context "/btc" do
        let(:endpoint) { "/api/currencies/btc" }

        it_behaves_like "a successful request" do
          it "returns Bitcoin" do
            expect(result.keys.sort).to eq currency_keys.sort
            expect_hash_match(result, bitcoin_parameters)
          end
        end
      end

      context "/very-invalid-currency" do
        let(:endpoint) { "/api/currencies/very-invalid-currency" }

        it_behaves_like "a failed request" do
          let(:code)    { 404 }
          let(:message) { "Not found" }
        end
      end
    end

    describe "#cryptocurrencies" do
      let(:endpoint) { "/api/currencies/cryptocurrencies" }

      it_behaves_like "a successful request" do
        it "returns a list of cryptocurrencies" do
          expect(result["currencies"].length).to eq result["count"]

          currency = result["currencies"].first
          expect(currency.keys.sort).to eq currency_keys.sort

          result["currencies"].each do |cur|
            expect(cur["is_cryptocurrency"]).to eq true
          end

          bitcoin = result["currencies"].select { |currency| currency["code"] == "btc" }.first
          expect_hash_match(bitcoin, bitcoin_parameters)
        end
      end
    end

    describe "#fiat" do
      let(:endpoint) { "/api/currencies/fiat" }

      it_behaves_like "a successful request" do
        it "returns a list of fiat currencies" do
          expect(result["currencies"].length).to eq result["count"]

          currency = result["currencies"].first
          expect(currency.keys.sort).to eq currency_keys.sort

          result["currencies"].each do |cur|
            expect(cur["is_fiat"]).to eq true
          end

          usdollar = result["currencies"].select { |currency| currency["code"] == "usd" }.first
          expect_hash_match(usdollar, usdollar_parameters)
        end
      end
    end

    describe "#tokens" do
      let(:endpoint) { "/api/currencies/tokens" }

      it_behaves_like "a successful request" do
        it "returns a list of Ethereum tokens" do
          expect(result["currencies"].length).to eq result["count"]

          currency = result["currencies"].first
          expect(currency.keys.sort).to eq currency_keys.sort

          result["currencies"].each do |cur|
            expect(cur["is_ethereum_token"]).to eq true
          end

          augur = result["currencies"].select { |currency| currency["code"] == "rep" }.first
          expect_hash_match(augur, augur_parameters)
        end
      end
    end
  end
end
