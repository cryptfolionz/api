require 'spec_helper'

describe "/portfolios/addresses" do
  include FetchSupport
  include Oauth2Support
  include PortfolioSupport

  it_behaves_like "an OAuth2 client" do
    let(:scopes) { "read write delete" }

    it_behaves_like "with a portfolio" do
      context "creating a new address" do
        let(:endpoint) { "/api/portfolios/#{portfolio["id"]}/addresses" }
        let(:address_title) { "New address #{Time.now} #{SecureRandom.hex}" }
        let(:arguments) { {
          title:      address_title,
          address:    "12UFNYqDRmkpHm9YJEuf96jAjyMXeP36Gp",
          currency:   "btc",
        } }

        it_behaves_like "a successful POST request" do
          before do
            @created_id = result["id"]
            expect(@created_id).to_not be_nil
          end

          it "returns the created address" do
            expect(result["title"]).to eq address_title
            expect(result["address"]).to eq arguments[:address]
            expect(result["currency"]["code"]).to eq "btc"
            expect(result["currency"]["title"]).to eq "Bitcoin"
            expect(result["valid"]).to eq true
          end

          context "then requesting the address balances" do
            let(:endpoint2) { "/api/portfolios/#{portfolio["id"]}/addresses/#{result["id"]}/balances"}

            it_behaves_like "a second successful request" do
              let(:wait_for_response) { true }

              it "returns a valid balance" do
                expect(result2.length).to eq 1
                expect(result2.first["currency"]["code"]).to eq "btc"

                expect_hash_match(result2.first, {
                  "balance":     "0.0",
                })
                expect(result2.first["transactions"]).to be >= 20

                expect(result2.first["created_at"]).to_not be_nil
                expect(result2.first["updated_at"]).to_not be_nil
                expect(result2.first["source"]).to_not be_nil
              end
            end
          end

          context "then requesting the address transactions" do
            let(:endpoint2) { "/api/portfolios/#{portfolio["id"]}/addresses/#{result["id"]}/transactions"}

            it_behaves_like "a second successful request" do
              let(:wait_for_response) { true }

              # Different explorers can have wildly different times on transactions,
              # the important thing is that the txn references and amounts are identical
              def expect_time_around(actual, expected)
                expect(Time.parse(actual)).to be >= expected - 12.hours
                expect(Time.parse(actual)).to be <= expected + 12.hours
              end

              it "returns valid transactions" do
                expect(result2.length).to be >= 20

                expect_hash_match(result2.first, {
                  "delta":     "-2.0",
                  "fee":       "0.00168574",
                  "reference": '3f5fae67a3e1172546e6e722e9e5e1500ede7720473eba17684615edc7fa2bae',
                })
                expect_time_around(result2.first['txn_at'], Time.parse('2017-12-21 00:31:44 +0000'))
                expect(result2.first["currency"]["code"]).to eq "btc"
                expect(result2.first["source"]).to_not be_nil

                expect_hash_match(result2.second, {
                  "delta":     "2.0",
                  "fee":       "0.0",
                  "reference": 'f642ba5aa54a511e51e5fbf61f0ba03f3138ee5aaa5da2e63d4b851bff31a169',
                })
                expect_time_around(result2.second['txn_at'], Time.parse('2017-12-20 22:34:01 +0000'))
                expect(result2.second["currency"]["code"]).to eq "btc"
                expect(result2.second["source"]).to_not be_nil

                expect_hash_match(result2.third, {
                  "delta":     "-1.78196236",
                  "fee":       "0.00080934",
                  "reference": 'f4a0baa60ba33c4904075a559943aeb4c5b5d3c6a57912eda41b4fd6946739c1',
                })
                expect_time_around(result2.third['txn_at'], Time.parse('2017-12-14 15:11:08 +0000'))
                expect(result2.third["currency"]["code"]).to eq "btc"
                expect(result2.third["source"]).to_not be_nil
              end
            end
          end
        end
      end
    end
  end
end
