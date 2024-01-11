require "test_helper"

class CashMovementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cash_movement = cash_movements(:one)
  end

  test "should get index" do
    get cash_movements_url
    assert_response :success
  end

  test "should get new" do
    get new_cash_movement_url
    assert_response :success
  end

  test "should create cash_movement" do
    assert_difference("CashMovement.count") do
      post cash_movements_url, params: { cash_movement: { amount: @cash_movement.amount, cash_in: @cash_movement.cash_in, cash_out: @cash_movement.cash_out, person: @cash_movement.person } }
    end

    assert_redirected_to cash_movement_url(CashMovement.last)
  end

  test "should show cash_movement" do
    get cash_movement_url(@cash_movement)
    assert_response :success
  end

  test "should get edit" do
    get edit_cash_movement_url(@cash_movement)
    assert_response :success
  end

  test "should update cash_movement" do
    patch cash_movement_url(@cash_movement), params: { cash_movement: { amount: @cash_movement.amount, cash_in: @cash_movement.cash_in, cash_out: @cash_movement.cash_out, person: @cash_movement.person } }
    assert_redirected_to cash_movement_url(@cash_movement)
  end

  test "should destroy cash_movement" do
    assert_difference("CashMovement.count", -1) do
      delete cash_movement_url(@cash_movement)
    end

    assert_redirected_to cash_movements_url
  end
end
