require 'spec_helper'

describe "/portfolios" do
  include FetchSupport
  include Oauth2Support
  include PortfolioSupport

  it_behaves_like "an OAuth2 client" do
    let(:scopes) { "read write delete" }

    context "creating a portfolio" do
      it_behaves_like "with a portfolio" do
        it "first deletes any existing portfolios" do
          expect(portfolio).to_not be_empty
        end
      end

      let(:endpoint) { "/api/portfolios" }
      let(:portfolio_title) { "New portfolio #{Time.now} #{SecureRandom.hex}" }
      let(:portfolio_currencies) { ["btc", "usd"] }
      let(:arguments) { {
        title:      portfolio_title,
        currencies: portfolio_currencies,
      } }

      it_behaves_like "a successful POST request" do
        before do
          @created_id = result["id"]
          expect(@created_id).to_not be_nil
        end

        it "returning the created portfolio" do
          expect(result["title"]).to eq portfolio_title
          expect(result["currencies"].map { |c| c["code"] }.sort).to eq portfolio_currencies.sort
        end

        describe "when we then request the portfolio" do
          let(:endpoint2) { "/api/portfolios/#{@created_id}" }

          it_behaves_like "a second successful request" do
            it "returning the new portfolio" do
              expect(result["title"]).to eq portfolio_title
              expect(result["currencies"].map { |c| c["code"] }.sort).to eq portfolio_currencies.sort
            end
          end
        end
      end

      context "not enough currencies are provided" do
        let(:portfolio_currencies) { [] }

        it_behaves_like "a failed POST request" do
          let(:error_code) { 422 }
          let(:message) { "Invalid" }

          it "includes the validation failure message" do
            expect(json["invalid"]).to include "must have at least one reporting currency selected"
          end
        end
      end

      context "an invalid currency code" do
        let(:portfolio_currencies) { ["totally invalid currency code"] }

        it_behaves_like "a failed POST request" do
          let(:error_code) { 404 }
          let(:message) { "Invalid" }
        end
      end
    end

    context "updating a portfolio" do
      it_behaves_like "with a portfolio" do
        let(:endpoint) { "/api/portfolios/#{portfolio["id"]}" }
        let(:new_title) { "An updated title at #{Time.now}" }
        let(:arguments) { { title: new_title } }

        it_behaves_like "a successful PATCH request" do
          it "returning the updated portfolio" do
            expect(result["id"]).to eq portfolio["id"]
            expect(result["title"]).to eq new_title
          end

          describe "when we then request the portfolio" do
            let(:endpoint2) { "/api/portfolios/#{portfolio["id"]}" }

            it_behaves_like "a second successful request" do
              it "returning the same portfolio" do
                expect(result["title"]).to eq new_title
              end
            end
          end
        end
      end
    end

    context "on an existing portfolio" do
      it_behaves_like "with a portfolio" do
        context "with an address" do
          it_behaves_like "with a bitcoin address" do
            context "then requesting all balances" do
              let(:endpoint) { "/api/portfolios/#{portfolio["id"]}/balances" }

              it_behaves_like "a successful request" do
                let(:wait_for_response) { true }

                it "returning a list of total balances" do
                  expect(result.length).to eq 2

                  expect(result.first["currency"]["code"]).to eq "btc"
                  expect(result.first["balance"].to_d).to be >= '0.00501'.to_d
                  expect(result.first["balance_at"]).to_not eq nil
                  expect(result.first["source"]).to_not eq nil

                  expect(result.second["currency"]["code"]).to eq "usd"
                  expect(result.second["balance"]).to eq "0.0"
                  expect(result.second["balance_at"]).to_not eq nil
                  expect(result.second["source"]).to_not eq nil
                end
              end
            end

            context "then requesting all converted balances" do
              let(:endpoint) { "/api/portfolios/#{portfolio["id"]}/converted" }

              it_behaves_like "a successful request" do
                let(:wait_for_response) { true }

                it "returning a list of total converted balances" do
                  expect(result.length).to eq 2

                  expect(result.first["currency"]["code"]).to eq "btc"
                  expect(result.first["balance"].to_d).to be >= '0.00501'.to_d
                  expect(result.first["balance_at"]).to_not eq nil
                  expect(result.first["source"]).to_not eq nil

                  expect(result.second["currency"]["code"]).to eq "usd"
                  expect(result.second["balance"].to_d).to be >= '1'.to_d
                  expect(result.second["balance_at"]).to_not eq nil
                  expect(result.second["source"]).to_not eq nil
                end
              end
            end
          end
        end
      end
    end

    # This also helps us maintain the remote list of user portfolios
    context "deleting all portfolios" do
      let(:endpoint) { "/api/portfolios" }

      it_behaves_like "a successful request" do
        it "we can delete all of the portfolios returned" do
          result.each do |portfolio|
            response = oauth2_token.delete("/api/portfolios/#{portfolio["id"]}")
            json = JSON.parse(response.body)
            expect_success(json)
            expect(json["result"]["id"]).to eq portfolio["id"]
          end
        end
      end
    end

    context "without valid scopes" do
      let(:scopes) { "read" }

      context "creating a portfolio" do
        let(:endpoint) { "/api/portfolios" }
        let(:portfolio_title) { "New portfolio #{Time.now} #{SecureRandom.hex}" }
        let(:portfolio_currencies) { ["btc", "usd"] }
        let(:arguments) { {
          title:      portfolio_title,
          currencies: portfolio_currencies,
        } }

        it_behaves_like "a forbidden POST request"
      end
    end
  end
end
