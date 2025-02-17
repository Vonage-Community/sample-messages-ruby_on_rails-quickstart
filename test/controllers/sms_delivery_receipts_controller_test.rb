require "test_helper"

class SmsDeliveryReceiptsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sms_delivery_receipts_create_url
    assert_response :success
  end
end
