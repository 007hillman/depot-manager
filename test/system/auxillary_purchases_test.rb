require "application_system_test_case"

class AuxillaryPurchasesTest < ApplicationSystemTestCase
  setup do
    @auxillary_purchase = auxillary_purchases(:one)
  end

  test "visiting the index" do
    visit auxillary_purchases_url
    assert_selector "h1", text: "Auxillary purchases"
  end

  test "should create auxillary purchase" do
    visit auxillary_purchases_url
    click_on "New auxillary purchase"

    fill_in "Amount spent", with: @auxillary_purchase.amount_spent
    fill_in "Purpose", with: @auxillary_purchase.purpose
    click_on "Create Auxillary purchase"

    assert_text "Auxillary purchase was successfully created"
    click_on "Back"
  end

  test "should update Auxillary purchase" do
    visit auxillary_purchase_url(@auxillary_purchase)
    click_on "Edit this auxillary purchase", match: :first

    fill_in "Amount spent", with: @auxillary_purchase.amount_spent
    fill_in "Purpose", with: @auxillary_purchase.purpose
    click_on "Update Auxillary purchase"

    assert_text "Auxillary purchase was successfully updated"
    click_on "Back"
  end

  test "should destroy Auxillary purchase" do
    visit auxillary_purchase_url(@auxillary_purchase)
    click_on "Destroy this auxillary purchase", match: :first

    assert_text "Auxillary purchase was successfully destroyed"
  end
end
