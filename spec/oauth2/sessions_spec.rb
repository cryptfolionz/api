require 'spec_helper'

describe "/user" do
  include FetchSupport
  include Oauth2Support

  context "without the OAuth2 application getting access to the user account" do
    it "returns a 400" do
      expect {
        fetch_json("#{ENV["HOST"]}/api/user")
      }.to raise_error(RestClient::BadRequest) do |e|
        json = JSON::parse(e.response.body)

        expect(json["success"]).to eq false
        expect(json["time"]).to be >= (Time.now - 1.hour).to_i
        expect(json["message"]).to eq "Requires login with OAuth2"
      end
    end
  end

  context "a registered OAuth2 client" do
    it_behaves_like "an OAuth2 client" do
      let(:scopes) { "read" }

      it_behaves_like "a successful request" do
        let(:endpoint) { "/api/user" }

        it "lists user information" do
          expect(result["name"]).to eq ENV['TEST_USER_NAME']
          expect(result["email"]).to eq ENV['TEST_USER_EMAIL']
        end
      end
    end
  end

  context "an unregistered OAuth2 client" do
    let(:oauth2_key) { "invalid" }

    it_behaves_like "an OAuth2 client" do
      let(:scopes) { "read" }

      it_behaves_like "a failed OAuth2 request" do
        let(:endpoint) { "/api/user" }
        let(:error_code) { "invalid_client" }
      end
    end
  end
end
