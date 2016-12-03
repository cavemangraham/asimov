require 'test_helper'

class BotControllerTest < ActionDispatch::IntegrationTest
  test "should get webhook" do
    get bot_webhook_url
    assert_response :success
  end

end
