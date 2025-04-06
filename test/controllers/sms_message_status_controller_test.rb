require "test_helper"

class SmsMessageStatusControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sms_message_status_create_url
    assert_response :success
  end
end
