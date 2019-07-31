require "rails_helper"

RSpec.describe 'Create Address' do
  describe 'As a Registered User' do
    before :each do

      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @home = @user.addresses.create!(street: "1111 Ash St.", city: "Denver", state: "CO", zip: "80220")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can click a link on my profile page to create a new address" do
      visit profile_path
      click_link("Add Address")
      expect(current_path).to eq(new_user_address_path)

      fill_in "Street", with: "2 LaHabre Dr"
      fill_in "City", with: "Pueblo"
      fill_in "State", with: "CO"
      fill_in "Zip", with: "81005"
      fill_in "Nickname", with: "Casita"

      click_button("Add New Address")
      expect(current_path).to eq(profile_path)
      casita = Address.last

      expect(@user.reload.addresses).to eq([@home, casita])
      expect(@user.reload.addresses[-1]).to eq(casita)
      expect(casita.street).to eq("2 LaHabre Dr")
      expect(casita.city).to eq("Pueblo")
      expect(casita.state).to eq("CO")
      expect(casita.zip).to eq(81005)
      expect(casita.nickname).to eq("Casita")
    end

    it "all fields in New Form are required" do
      visit profile_path

      click_link("Add Address")

      fill_in "Street", with: ""
      fill_in "City", with: ""
      fill_in "State", with: ""
      fill_in "Zip", with: ""
      fill_in "Nickname", with: ""
      click_button("Add New Address")

      expect(page).to have_content("Nickname can't be blank. Street can't be blank. City can't be blank. State can't be blank. Zip can't be blank")
    end
  end
end
