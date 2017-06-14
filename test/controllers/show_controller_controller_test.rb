require 'test_helper'

class ShowControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get show_user" do
    get show_controller_show_user_url
    assert_response :success
  end

end
