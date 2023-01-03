require "test_helper"

class DebtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @debt = debts(:one)
  end

  test "should get index" do
    get debts_url
    assert_response :success
  end

  test "should get new" do
    get new_debt_url
    assert_response :success
  end

  test "should create debt" do
    assert_difference("Debt.count") do
      post debts_url, params: { debt: { cash_in: @debt.cash_in, cash_out: @debt.cash_out, client_name: @debt.client_name } }
    end

    assert_redirected_to debt_url(Debt.last)
  end

  test "should show debt" do
    get debt_url(@debt)
    assert_response :success
  end

  test "should get edit" do
    get edit_debt_url(@debt)
    assert_response :success
  end

  test "should update debt" do
    patch debt_url(@debt), params: { debt: { cash_in: @debt.cash_in, cash_out: @debt.cash_out, client_name: @debt.client_name } }
    assert_redirected_to debt_url(@debt)
  end

  test "should destroy debt" do
    assert_difference("Debt.count", -1) do
      delete debt_url(@debt)
    end

    assert_redirected_to debts_url
  end
end
