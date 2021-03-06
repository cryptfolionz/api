require 'oauth2'
require_relative 'api_support'

module Oauth2Support
  include ApiSupport

  shared_examples "an OAuth2 client" do
    let(:oauth2_key) { ENV['OAUTH2_KEY'] || fail("Need OAUTH2_KEY env variable set") }
    let(:oauth2_secret) { ENV['OAUTH2_SECRET'] || fail("Need OAUTH2_SECRET env variable set") }

    let(:user_email) { ENV['TEST_USER_EMAIL'] || fail("Need TEST_USER_EMAIL env verified set") }
    let(:user_password) { ENV['TEST_USER_PASSWORD'] || fail("Need TEST_USER_PASSWORD env verified set") }

    # Normally, this will be the endpoint of your application
    let(:redirect_uri) { ENV['OAUTH2_REDIRECT_URI'] || fail("Need OAUTH2_REDIRECT_URI env variable set") }

    let(:oauth2_client) do
      OAuth2::Client.new(oauth2_key, oauth2_secret,
        site:          ENV['HOST'],
        token_url:     "/oauth/token",
        authorize_url: "/oauth/authorize")
    end

    let(:oauth2_token) do
      # At this point, you would redirect the user to auth_url. CryptFolio will handle
      # login and authorisation, and once successful, redirects the user to the redirect_uri
      # with a code. i.e. /redirect_uri?code=ABC123
      #
      # auth_url = @oauth2_client.auth_code.authorize_url(redirect_uri: redirect_uri, scope: scopes)
      # redirect_to(auth_url)
      #
      # ... and on redirect_uri:
      # code = params[:code]
      # token = @oauth2_client.auth_code.get_token(code, redirect_uri: redirect_uri)

      # However, because we're in a spec, and we don't really want to deal with creating a
      # web browser and logging in as a user and all that jazz, we will use a temporary workaround:
      # to login directly with a username and password.
      #
      # NOTE this will only work for CryptFolio users where allow_remote_login=true,
      # and only Enterprise users can request this to be enabled. You should be using
      # the normal OAuth2 flow instead.
      oauth2_client.password.get_token(user_email, user_password, scope: scopes)
    end

    let(:remote_client) { oauth2_token }

    shared_examples "a failed OAuth2 POST request" do
      let(:error_code) { 400 } # Default
      let(:response) do
        response = nil
        expect {
          oauth2_token.post(endpoint, { body: arguments })
        }.to raise_error(OAuth2::Error) do |e|
          expect(e.response.status).to eq error_code
          response = e.response
        end
        response
      end
      let(:json) { JSON.parse(response.body) }
      let(:result) do
        expect_failure(json)
        json["result"]
      end
    end

    shared_examples "a failed OAuth2 request" do
      it "raises an error" do
        expect {
          oauth2_token.get(endpoint)
        }.to raise_error(OAuth2::Error) do |e|
          expect(e.code).to eq error_code
          expect(e.response.status).to eq 401
        end
      end
    end

    shared_examples "a forbidden OAuth2 request" do
      it "raises an error" do
        expect {
          oauth2_token.get(endpoint)
        }.to raise_error(OAuth2::Error) do |e|
          expect(e.code).to eq nil
          expect(e.response.status).to eq 403
        end
      end
    end

    shared_examples "a forbidden POST request" do
      it "raises an error" do
        expect {
          oauth2_token.post(endpoint, { body: arguments })
        }.to raise_error(OAuth2::Error) do |e|
          expect(e.code).to eq nil
          expect(e.response.status).to eq 403
        end
      end
    end
  end
end
