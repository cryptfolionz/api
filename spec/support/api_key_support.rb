require 'oauth2'
require_relative 'api_support'
require_relative 'fetch_support'

module ApiKeySupport
  include ApiSupport

  shared_examples "using an API key" do
    let(:api_key) { ENV['TEST_API_KEY'] || fail("Need TEST_API_KEY env variable set") }

    class RestClientResponse
      attr_reader :body

      def initialize(body)
        @body = body
      end
    end

    class RestClientWrapper
      include FetchSupport

      attr_reader :api_key

      def initialize(api_key)
        @api_key = api_key
      end

      def get(path)
        # TODO will fail if we are passing ?arguments in - implement later
        body = fetch_json("#{ENV['HOST']}/#{path}?api_key=#{api_key}")
        return RestClientResponse.new(body.to_json)
      end
    end

    let(:remote_client) { RestClientWrapper.new(api_key) }
  end
end
