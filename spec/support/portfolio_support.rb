# Automates the process of creating a portfolio to test with
module PortfolioSupport
  include Oauth2Support

  shared_examples "with a portfolio" do
    let(:create_portfolio_endpoint) { "/api/portfolios" }
    let(:create_portfolio_arguments) { {
      title: "New portfolio #{SecureRandom.hex}",
      currencies: ["btc", "usd"],
    } }
    let(:create_portfolio_response) { oauth2_token.post(create_portfolio_endpoint, { body: create_portfolio_arguments }) }
    let(:create_portfolio_json) { JSON.parse(create_portfolio_response.body) }
    let(:create_portfolio_result) do
      expect_success(create_portfolio_json)
      create_portfolio_json["result"]
    end
    let(:portfolio) { create_portfolio_result }
  end
end
