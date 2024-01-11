require "application_system_test_case"

class CashMovementsTest < ApplicationSystemTestCase
  setup do
    @cash_movement = cash_movements(:one)
  end

  test "visiting the index" do
    visit cash_movements_url
    assert_selector "h1", text: "Cash movements"
  end

  test "should create cash movement" do
    visit cash_movements_url
    click_on "New cash movement"

    fill_in "Amount", with: @cash_movement.amount
    check "Cash in" if @cash_movement.cash_in
    check "Cash out" if @cash_movement.cash_out
    fill_in "Person", with: @cash_movement.person
    click_on "Create Cash movement"

    assert_text "Cash movement was successfully created"
    click_on "Back"
  end

  test "should update Cash movement" do
    visit cash_movement_url(@cash_movement)
    click_on "Edit this cash movement", match: :first

    fill_in "Amount", with: @cash_movement.amount
    check "Cash in" if @cash_movement.cash_in
    check "Cash out" if @cash_movement.cash_out
    fill_in "Person", with: @cash_movement.person
    click_on "Update Cash movement"

    assert_text "Cash movement was successfully updated"
    click_on "Back"
  end

  test "should destroy Cash movement" do
    visit cash_movement_url(@cash_movement)
    click_on "Destroy this cash movement", match: :first

    assert_text "Cash movement was successfully destroyed"
  end
end
