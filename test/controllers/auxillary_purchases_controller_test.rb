require "test_helper"

class AuxillaryPurchasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auxillary_purchase = auxillary_purchases(:one)
  end

  test "should get index" do
    get auxillary_purchases_url
    assert_response :success
  end

  test "should get new" do
    get new_auxillary_purchase_url
    assert_response :success
  end

  test "should create auxillary_purchase" do
    assert_difference("AuxillaryPurchase.count") do
      post auxillary_purchases_url, params: { auxillary_purchase: { amount_spent: @auxillary_purchase.amount_spent, purpose: @auxillary_purchase.purpose } }
    end

    assert_redirected_to auxillary_purchase_url(AuxillaryPurchase.last)
  end

  test "should show auxillary_purchase" do
    get auxillary_purchase_url(@auxillary_purchase)
    assert_response :success
  end

  test "should get edit" do
    get edit_auxillary_purchase_url(@auxillary_purchase)
    assert_response :success
  end

  test "should update auxillary_purchase" do
    patch auxillary_purchase_url(@auxillary_purchase), params: { auxillary_purchase: { amount_spent: @auxillary_purchase.amount_spent, purpose: @auxillary_purchase.purpose } }
    assert_redirected_to auxillary_purchase_url(@auxillary_purchase)
  end

  test "should destroy auxillary_purchase" do
    assert_difference("AuxillaryPurchase.count", -1) do
      delete auxillary_purchase_url(@auxillary_purchase)
    end

    assert_redirected_to auxillary_purchases_url
  end
end
