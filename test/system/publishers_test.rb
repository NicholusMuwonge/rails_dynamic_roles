require "application_system_test_case"

class PublishersTest < ApplicationSystemTestCase
  setup do
    @publisher = publishers(:one)
  end

  test "visiting the index" do
    visit publishers_url
    assert_selector "h1", text: "Publishers"
  end

  test "should create publisher" do
    visit publishers_url
    click_on "New publisher"

    fill_in "Description", with: @publisher.description
    fill_in "Name", with: @publisher.name
    click_on "Create Publisher"

    assert_text "Publisher was successfully created"
    click_on "Back"
  end

  test "should update Publisher" do
    visit publisher_url(@publisher)
    click_on "Edit this publisher", match: :first

    fill_in "Description", with: @publisher.description
    fill_in "Name", with: @publisher.name
    click_on "Update Publisher"

    assert_text "Publisher was successfully updated"
    click_on "Back"
  end

  test "should destroy Publisher" do
    visit publisher_url(@publisher)
    click_on "Destroy this publisher", match: :first

    assert_text "Publisher was successfully destroyed"
  end
end
