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
  end
end
