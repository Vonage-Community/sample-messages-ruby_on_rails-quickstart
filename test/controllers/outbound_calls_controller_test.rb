require "test_helper"

class OutboundCallsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get outbound_calls_index_url
    assert_response :success
  end

  test "should get create" do
    get outbound_calls_create_url
    assert_response :success
  end

  test "should get show" do
    get outbound_calls_show_url
    assert_response :success
  end
end
