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
        end
      end
    end
  end
end
