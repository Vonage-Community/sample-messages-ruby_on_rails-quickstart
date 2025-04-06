require "test_helper"

class InboundSmsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get inbound_sms_create_url
    assert_response :success
  end
end
