require "test_helper"

class OutboundRcsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get outbound_rcs_new_url
    assert_response :success
  end

  test "should get create" do
    get outbound_rcs_create_url
    assert_response :success
  end
end
