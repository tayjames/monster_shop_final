require "rails_helper"

RSpec.describe "User registration with address" do
  it "can register a new user with default address equal to 'Home'" do
    visit root_path
    click_on "Register"
    # save_and_open_page

    fill_in "Name", with: "Tay James"
    fill_in "user[email]", with: "james.tay@gmail.com"
    fill_in "user[addresses_attributes][0][street]", with: "1111 Ash St"
    fill_in "user[addresses_attributes][0][city]", with: "Denver"
    fill_in "user[addresses_attributes][0][state]", with: "CO"
    fill_in "user[addresses_attributes][0][zip]", with: "80220"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Register User"

    user = User.last

    expect(current_path).to eq(profile_path)
    expect(user.addresses[0][:nickname]).to eq("Home")
  end
end
