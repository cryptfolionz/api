require 'spec_helper'

describe "/user" do
  include FetchSupport
  include Oauth2Support
  include ApiKeySupport

  let(:endpoint) { "/api/user" }

  context "without the OAuth2 application getting access to the user account" do
    it "returns a 401" do
      expect {
        fetch_json("#{ENV["HOST"]}#{endpoint}")
      }.to raise_error(RestClient::Unauthorized)
    end
  end

  context "a registered OAuth2 client" do
    it_behaves_like "an OAuth2 client" do
      let(:scopes) { "read" }

      it_behaves_like "a successful request" do
        it "lists user information" do
          expect(result["name"]).to eq ENV['TEST_USER_NAME']
          expect(result["email"]).to eq ENV['TEST_USER_EMAIL']
        end
      end

      context "with an invalid user" do
        let(:user_email) { "invalid" }

        it_behaves_like "a failed OAuth2 request" do
          let(:error_code) { "invalid_grant" }
        end
      end

      context "with an invalid scope" do
        let(:scopes) { "invalid" }

        it_behaves_like "a failed OAuth2 request" do
          let(:error_code) { "invalid_scope" }
        end
      end

      context "with a scope that doesn't provide enough access" do
        let(:scopes) { "public" }

        it_behaves_like "a forbidden OAuth2 request"
      end
    end
  end

  context "an unregistered OAuth2 client" do
    it_behaves_like "an OAuth2 client" do
      let(:oauth2_key) { "invalid" }
      let(:scopes) { "read" }

      it_behaves_like "a failed OAuth2 request" do
        let(:error_code) { "invalid_client" }
      end
    end
  end

  it_behaves_like "using an API key" do
    it_behaves_like "a successful request" do
      it "lists user information" do
        expect(result["name"]).to eq ENV['TEST_USER_NAME']
        expect(result["email"]).to eq ENV['TEST_USER_EMAIL']
      end
    end

    context "an invalid API key" do
      let(:api_key) { "invalid" }

      it_behaves_like "a failed GET request" do
        let(:error_code) { "invalid_client" }
      end
    end
  end
end
