require "rails_helper"

RSpec.describe "Editing address" do
  describe "As a loggin in user" do
    before :each do
      @user = User.create!(name: "Tay James", email: "james.tay@gmail.com", password: "password")
      @home = @user.addresses.create!(street: "1111 Ash St.", city: "Denver", state: "CO", zip: "80220")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can click a link to edit an address on file" do
      visit profile_path
      # binding.pry
      # save_and_open_page
      within "#address-#{@home.id}" do
        click_link("Edit Address")
      end
      # binding.pry
      expect(current_path).to eq(edit_user_address_path(@home))
      fill_in "Street", with: "2 LaHabre Dr"
      fill_in "City", with: "Pueblo"
      fill_in "State", with: "CO"
      fill_in "Zip", with: "81005"
      fill_in "Nickname", with: "Casita"

      click_button("Update Address")
      expect(current_path).to eq(profile_path)

      expect(@home.reload.street).to eq("2 LaHabre Dr")
      expect(@home.reload.city).to eq("Pueblo")
      expect(@home.reload.state).to eq("CO")
      expect(@home.reload.zip).to eq(81005)
      expect(@home.reload.nickname).to eq("Casita")
    end

    it "I cannot edit an address with shipped orders" do
      order = Order.create!(user: @user, address_id: @home.id, status: 'shipped')

      visit profile_path

      within "#address-#{@home.id}" do
        expect(page).to_not have_link("Edit Address")
      end
    end
  end
end
