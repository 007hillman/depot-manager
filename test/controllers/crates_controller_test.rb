require "test_helper"

class CratesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crate = crates(:one)
  end

  test "should get index" do
    get crates_url
    assert_response :success
  end

  test "should get new" do
    get new_crate_url
    assert_response :success
  end

  test "should create crate" do
    assert_difference("Crate.count") do
      post crates_url, params: { crate: { client_id: @crate.client_id, number_of_crates_given: @crate.number_of_crates_given } }
    end

    assert_redirected_to crate_url(Crate.last)
  end

  test "should show crate" do
    get crate_url(@crate)
    assert_response :success
  end

  test "should get edit" do
    get edit_crate_url(@crate)
    assert_response :success
  end

  test "should update crate" do
    patch crate_url(@crate), params: { crate: { client_id: @crate.client_id, number_of_crates_given: @crate.number_of_crates_given } }
    assert_redirected_to crate_url(@crate)
  end

  test "should destroy crate" do
    assert_difference("Crate.count", -1) do
      delete crate_url(@crate)
    end

    assert_redirected_to crates_url
  end
end
