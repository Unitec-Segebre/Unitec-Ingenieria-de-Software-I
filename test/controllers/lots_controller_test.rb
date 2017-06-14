require 'test_helper'

class LotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lots_index_url
    assert_response :success
  end

  test "should get new" do
    get lots_new_url
    assert_response :success
  end

  test "should get show" do
    get lots_show_url
    assert_response :success
  end

end
