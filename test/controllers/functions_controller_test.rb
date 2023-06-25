require "test_helper"

class FunctionsControllerTest < ActionDispatch::IntegrationTest
  test "should get goods_consumption" do
    get functions_goods_consumption_url
    assert_response :success
  end
end
