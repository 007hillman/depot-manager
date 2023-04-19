require "application_system_test_case"

class CratesTest < ApplicationSystemTestCase
  setup do
    @crate = crates(:one)
  end

  test "visiting the index" do
    visit crates_url
    assert_selector "h1", text: "Crates"
  end

  test "should create crate" do
    visit crates_url
    click_on "New crate"

    fill_in "Client", with: @crate.client_id
    fill_in "Number of crates given", with: @crate.number_of_crates_given
    click_on "Create Crate"

    assert_text "Crate was successfully created"
    click_on "Back"
  end

  test "should update Crate" do
    visit crate_url(@crate)
    click_on "Edit this crate", match: :first

    fill_in "Client", with: @crate.client_id
    fill_in "Number of crates given", with: @crate.number_of_crates_given
    click_on "Update Crate"

    assert_text "Crate was successfully updated"
    click_on "Back"
  end

  test "should destroy Crate" do
    visit crate_url(@crate)
    click_on "Destroy this crate", match: :first

    assert_text "Crate was successfully destroyed"
  end
end
