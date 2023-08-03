require "test_helper"

class WhiteBreadStoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get white_bread_store_index_url
    assert_response :success
  end
end
