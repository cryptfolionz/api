require 'oauth2'

module ApiSupport
  def expect_success(json)
    expect(json["success"]).to eq true
    expect(json["time"]).to be >= (Time.now - 1.hour).to_i
    expect(json["time"]).to be <= (Time.now + 1.hour).to_i
    expect(json["result"]).to_not be_nil
  end

  def expect_failure(json)
    expect(json["success"]).to eq false
    expect(json["time"]).to be >= (Time.now - 1.hour).to_i
    expect(json["time"]).to be <= (Time.now + 1.hour).to_i
    expect(json["message"]).to eq message
    expect(json["result"]).to be_nil
  end

  def asynchronous_get_request(remote_client, endpoint)
    begin
      response = remote_client.get(endpoint)
    rescue OAuth2::Error => e
      json = JSON.parse(e.response.body)
      count = 0
      while wait_for_response && json["success"] == false && json["message"] == "Not ready" && e.response.status == 503
        count += 1
        if count > 7
          raise "Gave up waiting for #{endpoint} to be ready"
        end

        putc "z"
        sleep(2 ** count) # exponential backoff
        begin
          response = remote_client.get(endpoint)
          json = JSON.parse(response.body)
        rescue OAuth2::Error => e2
          # Try again...
          e = e2
          json = JSON.parse(e2.response.body)
        end
      end

      expect_success(json)
    end
    response
  end

  shared_examples "a successful request" do
    let(:wait_for_response) { false }
    let(:response) { asynchronous_get_request(remote_client, endpoint) }
    let(:json) { JSON.parse(response.body) }
    let(:result) do
      expect_success(json)
      json["result"]
    end
  end

  shared_examples "a second successful request" do
    let(:wait_for_response) { false }
    let(:response2) { asynchronous_get_request(remote_client, endpoint2) }
    let(:json2) { JSON.parse(response2.body) }
    let(:result2) do
      expect_success(json2)
      json2["result"]
    end
  end

  shared_examples "a successful POST request" do
    let(:response) { remote_client.post(endpoint, { body: arguments }) }
    let(:json) { JSON.parse(response.body) }
    let(:result) do
      expect_success(json)
      json["result"]
    end
  end

  shared_examples "a successful PATCH request" do
    let(:response) { remote_client.patch(endpoint, { body: arguments }) }
    let(:json) { JSON.parse(response.body) }
    let(:result) do
      expect_success(json)
      json["result"]
    end
  end

  shared_examples "a second successful PATCH request" do
    let(:response2) { remote_client.patch(endpoint2, { body: arguments2 }) }
    let(:json2) { JSON.parse(response2.body) }
    let(:result2) do
      expect_success(json2)
      json2["result"]
    end
  end

  shared_examples "a failed GET request" do
    let(:error_code) { 400 } # Default
    let(:response) { asynchronous_get_request(remote_client, endpoint) }
    let(:json) { JSON.parse(response.body) }
    let(:result) do
      expect_failure(json)
      json["result"]
    end
  end
end
