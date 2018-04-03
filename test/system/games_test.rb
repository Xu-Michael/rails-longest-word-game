require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "div.letter", count: 10
  end

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    fill_in "input", with: "random"
    click_on "button"
    assert_text "can't be built out of the above letters"
  end
end
