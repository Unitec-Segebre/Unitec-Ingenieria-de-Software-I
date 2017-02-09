require 'test_helper'

class LotesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lotes_index_url
    assert_response :success
  end

  test "should get new" do
    get lotes_new_url
    assert_response :success
  end

  test "should get show" do
    get lotes_show_url
    assert_response :success
  end

end
