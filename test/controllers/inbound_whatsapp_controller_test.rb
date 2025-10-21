require "test_helper"

class InboundWhatsappControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inbound_whatsapp_index_url
    assert_response :success
  end

  test "should get inbound" do
    get inbound_whatsapp_inbound_url
    assert_response :success
  end

  test "should get status" do
    get inbound_whatsapp_status_url
    assert_response :success
  end
end
