require "rails_helper"

RSpec.describe "User registration with address" do
  it "can register a new user with default address equal to 'Home'" do
    visit root_path
    click_on "Register"

    fill_in "Name", with: "Tay James"
    fill_in "user[email]", with: "james.tay@gmail.com"
    fill_in "user[addresses_attributes][0][street]", with: "1111 Ash St"
    fill_in "user[addresses_attributes][0][city]", with: "Denver"
    fill_in "user[addresses_attributes][0][state]", with: "CO"
    fill_in "user[addresses_attributes][0][zip]", with: "80220"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"

    click_button "Register User"
    expect(current_path).to eq(profile_path)
    home = Address.last
    user = User.last

    expect(user.reload.addresses[-1]).to eq(home)
    expect(home.street).to eq("1111 Ash St")
    expect(home.city).to eq("Denver")
    expect(home.state).to eq("CO")
    expect(home.zip).to eq(80220)
    expect(home.nickname).to eq("Home")
  end
end
