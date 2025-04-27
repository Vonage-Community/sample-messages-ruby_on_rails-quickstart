require "test_helper"

class CallEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get call_events_create_url
    assert_response :success
  end
end
