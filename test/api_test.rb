require "custodian"
require "minitest/spec"
require "minitest/autorun"
require "rack/test"

describe Custodian::API do
  include Rack::Test::Methods

  def app
    Custodian::API.new
  end

  it "responds with HTTP 200 OK" do
    get "/"

    last_response.ok?.must_equal true
  end

  it "responds with valid JSON" do
    get "/"

    response = JSON.parse last_response.body

    response.must_be_instance_of Array
  end
end
