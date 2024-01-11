require "application_system_test_case"

class FixedAssetsTest < ApplicationSystemTestCase
  setup do
    @fixed_asset = fixed_assets(:one)
  end

  test "visiting the index" do
    visit fixed_assets_url
    assert_selector "h1", text: "Fixed assets"
  end

  test "should create fixed asset" do
    visit fixed_assets_url
    click_on "New fixed asset"

    fill_in "Asset name", with: @fixed_asset.asset_name
    fill_in "Asset unit price", with: @fixed_asset.asset_unit_price
    click_on "Create Fixed asset"

    assert_text "Fixed asset was successfully created"
    click_on "Back"
  end

  test "should update Fixed asset" do
    visit fixed_asset_url(@fixed_asset)
    click_on "Edit this fixed asset", match: :first

    fill_in "Asset name", with: @fixed_asset.asset_name
    fill_in "Asset unit price", with: @fixed_asset.asset_unit_price
    click_on "Update Fixed asset"

    assert_text "Fixed asset was successfully updated"
    click_on "Back"
  end

  test "should destroy Fixed asset" do
    visit fixed_asset_url(@fixed_asset)
    click_on "Destroy this fixed asset", match: :first

    assert_text "Fixed asset was successfully destroyed"
  end
end
