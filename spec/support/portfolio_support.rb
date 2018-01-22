# Automates the process of creating a portfolio to test with
module PortfolioSupport
  include Oauth2Support

  shared_examples "with a portfolio" do
    let(:create_portfolio_endpoint) { "/api/portfolios" }
    let(:create_portfolio_arguments) { {
      title: "New portfolio #{SecureRandom.hex}",
      currencies: ["btc", "usd"],
    } }
    let(:create_portfolio_response) do
      begin
        # Try do it normally...
        putc "p" # Make it clear when we're waiting for a portfolio to be created
        oauth2_token.post(create_portfolio_endpoint, { body: create_portfolio_arguments })

      rescue OAuth2::Error => e
        # Did it fail because the user is full of portfolios?
        json = JSON.parse(e.response.body)
        if json["message"] == "Invalid" && json["invalid"].first == "User has more portfolios than permitted by the current plan"
          # Yes; we should try deleting them all before continuing
          puts "--> Deleting all existing portfolios before continuing..."
          delete_all_portfolios!

          # And then try again
          oauth2_token.post(create_portfolio_endpoint, { body: create_portfolio_arguments })
        else
          raise e
        end
      end
    end
    let(:create_portfolio_json) { JSON.parse(create_portfolio_response.body) }
    let(:create_portfolio_result) do
      expect_success(create_portfolio_json)
      create_portfolio_json["result"]
    end
    let!(:portfolio) { create_portfolio_result }

    def delete_all_portfolios!
      response = oauth2_token.get("/api/portfolios")
      json = JSON.parse(response.body)
      expect_success(json)
      json["result"].each do |portfolio|
        response = oauth2_token.delete("/api/portfolios/#{portfolio["id"]}")
        json = JSON.parse(response.body)
        expect_success(json)
      end
      puts "--> Deleted #{json["result"].count} existing portfolios"
    end

    shared_examples "with a bitcoin address" do
      let(:create_address_address) { "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu" }
      let(:create_address_endpoint) { "/api/portfolios/#{portfolio["id"]}/addresses" }
      let(:create_address_arguments) { {
        title: "New address #{SecureRandom.hex}",
        currency: ["btc"],
        address: create_address_address,
      } }
      let(:create_address_response) { oauth2_token.post(create_address_endpoint, { body: create_address_arguments }) }
      let(:create_address_json) { JSON.parse(create_address_response.body) }
      let(:create_address_result) do
        expect_success(create_address_json)
        create_address_json["result"]
      end
      let!(:address) { create_address_result }
    end
  end
end
