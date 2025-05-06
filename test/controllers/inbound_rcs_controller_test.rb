require "test_helper"

class InboundRcsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get inbound_rcs_create_url
    assert_response :success
  end
end
