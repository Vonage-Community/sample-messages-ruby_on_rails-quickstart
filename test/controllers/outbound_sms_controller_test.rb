require "test_helper"

class OutboundSmsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get outbound_sms_index_url
    assert_response :success
  end

  test "should get create" do
    get outbound_sms_create_url
    assert_response :success
  end
end
