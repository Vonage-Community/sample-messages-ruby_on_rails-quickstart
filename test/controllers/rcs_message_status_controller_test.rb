require "test_helper"

class RcsMessageStatusControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get rcs_message_status_create_url
    assert_response :success
  end
end
