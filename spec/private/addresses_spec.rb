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
        let(:portfolio_title) { "New address #{Time.now} #{SecureRandom.hex}" }
        let(:arguments) { {
          title:      portfolio_title,
          address:    "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu",
          currency:   "btc",
        } }

        it_behaves_like "a successful POST request" do
          before do
            @created_id = result["id"]
            expect(@created_id).to_not be_nil
          end

          it "returns the created address" do
            expect(result["title"]).to eq portfolio_title
            expect(result["address"]).to eq "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu"
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
                  "balance":     "50.00501",
                  "sent":        "0.0",
                  "received":    "50.00501",
                  "transactions": 3,
                })

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

              it "returns valid transactions" do
                expect(result2.length).to eq 3

                expect_hash_match(result2.first, {
                  "delta":     "0.005",
                  "fee":       "0.0",
                  "txn_at":    Time.parse('2016-05-02 22:24:11 +0000').iso8601,
                  "reference": '06d7d63d6c1966a378bbbd234a27a5b583f37d3bdf9fb9ef50f4724c86b4559b',
                })
                expect(result2.first["currency"]["code"]).to eq "btc"
                expect(result2.first["source"]).to_not be_nil

                expect_hash_match(result2.second, {
                  "delta":     "0.00001",
                  "fee":       "0.0",
                  # Not all providers give accurate sub-minute times
                  # "txn_at":    Time.parse('2015-07-22 10:12:51 +0000').iso8601,
                  "reference": 'b565336983c6139e2fd4d5bdd127d7a8b94e9d2dba084a97c002871766a079f3',
                })
                expect(result2.second["currency"]["code"]).to eq "btc"
                expect(result2.second["source"]).to_not be_nil

                expect_hash_match(result2.third, {
                  "delta":     "50.0",
                  "fee":       "0.0",
                  "txn_at":    Time.parse('2009-01-09 03:23:48 +0000').iso8601,
                  "reference": '63522845d294ee9b0188ae5cac91bf389a0c3723f084ca1025e7d9cdfe481ce1',
                })
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
