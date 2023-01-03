require "application_system_test_case"

class DrinksTest < ApplicationSystemTestCase
  setup do
    @drink = drinks(:one)
  end

  test "visiting the index" do
    visit drinks_url
    assert_selector "h1", text: "Drinks"
  end

  test "should create drink" do
    visit drinks_url
    click_on "New drink"

    check "Alcoholic" if @drink.alcoholic
    fill_in "Name", with: @drink.name
    fill_in "Packaging", with: @drink.packaging
    fill_in "Retail price", with: @drink.retail_price
    fill_in "Size", with: @drink.size
    fill_in "Supplyer", with: @drink.supplyer
    fill_in "Wholesale price", with: @drink.wholesale_price
    click_on "Create Drink"

    assert_text "Drink was successfully created"
    click_on "Back"
  end

  test "should update Drink" do
    visit drink_url(@drink)
    click_on "Edit this drink", match: :first

    check "Alcoholic" if @drink.alcoholic
    fill_in "Name", with: @drink.name
    fill_in "Packaging", with: @drink.packaging
    fill_in "Retail price", with: @drink.retail_price
    fill_in "Size", with: @drink.size
    fill_in "Supplyer", with: @drink.supplyer
    fill_in "Wholesale price", with: @drink.wholesale_price
    click_on "Update Drink"

    assert_text "Drink was successfully updated"
    click_on "Back"
  end

  test "should destroy Drink" do
    visit drink_url(@drink)
    click_on "Destroy this drink", match: :first

    assert_text "Drink was successfully destroyed"
  end
end
