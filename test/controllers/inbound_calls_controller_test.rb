require "test_helper"

class InboundCallsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get inbound_calls_create_url
    assert_response :success
  end
end
