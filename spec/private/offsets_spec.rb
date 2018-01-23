require 'spec_helper'

describe "/portfolios/offsets" do
  include FetchSupport
  include Oauth2Support
  include PortfolioSupport

  it_behaves_like "an OAuth2 client" do
    let(:scopes) { "read write delete" }

    it_behaves_like "with a portfolio" do
      context "creating a new offset" do
        let(:endpoint) { "/api/portfolios/#{portfolio["id"]}/offsets" }
        let(:offset_title) { "New offset #{Time.now} #{SecureRandom.hex}" }
        let(:arguments) { {
          title:    offset_title,
          balances: [
            { currency: "btc", balance: 1 },
            { currency: "ltc", balance: 2 },
          ]
        } }
        let(:offset) { result }

        it_behaves_like "a successful POST request" do
          before do
            expect(offset["id"]).to_not be_nil
          end

          it "returns the created offset" do
            expect(offset["title"]).to eq offset_title
            expect(offset["balances"].count).to eq 2
            expect(offset["balances"].first["currency"]["code"]).to eq "btc"
            expect(offset["balances"].first["balance"]).to eq "1.0"
            expect(offset["balances"].second["currency"]["code"]).to eq "ltc"
            expect(offset["balances"].second["balance"]).to eq "2.0"
          end

          context "and then updating the balances" do
            let(:endpoint2) { "/api/portfolios/#{portfolio["id"]}/offsets/#{offset["id"]}" }
            let(:arguments2) { {
              balances: [
                { currency: "usd", balance: 4 },
                { currency: "btc", balance: 3 },
              ]
            } }
            let(:offset2) { result2 }

            it_behaves_like "a second successful PATCH request" do
              before do
                expect(offset2["id"]).to_not be_nil
              end

              it "returns the created offset2" do
                expect(offset2["title"]).to eq offset_title # hasn't changed
                expect(offset2["balances"].count).to eq 2
                expect(offset2["balances"].first["currency"]["code"]).to eq "btc"
                expect(offset2["balances"].first["balance"]).to eq "3.0"
                # Note that LTC is no longer present
                expect(offset2["balances"].second["currency"]["code"]).to eq "usd"
                expect(offset2["balances"].second["balance"]).to eq "4.0"
              end
            end
          end
        end
      end
    end
  end
end
