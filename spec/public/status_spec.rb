require 'spec_helper'

describe "/status" do
  include FetchSupport

  it_behaves_like "a web client" do
    describe "#index" do
      let(:endpoint) { "/api/status" }

      it_behaves_like "a successful request" do
        it "shows the site is working as expected" do
          expect(result["ok"]).to include("tickers")
          expect(result["ok"]).to include("jobs")
        end
      end
    end
  end
end
