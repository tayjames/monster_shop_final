require "rails_helper"

RSpec.describe 'Delete Address' do
  describe 'As a registered user' do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @home = @user.addresses.create!(street: "1111 Ash St.", city: "Denver", state: "CO", zip: "80220")
      @casita = @user.addresses.create!(street: "2 LaHabre Dr.", city: "Pueblo", state: "CO", zip: "81005", nickname: "casita")
    end

    it "I can click a link on my profile page to delete that address" do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      within "#address-#{@home.id}" do
        click_button 'Delete'
      end

      expect(current_path).to eq(profile_path)
      expect(page).to_not have_content(@home.id)
    end

    it "I cannot delete an address if it's being used for a shipped order" do
      order = Order.create!(user: @user, address_id: @casita.id, status: 'shipped')
      order = Order.create!(user: @user, address_id: @home.id, status: 'pending')

      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      within "#address-#{@casita.id}" do
        expect(page).to_not have_button("Delete Address")
      end

      within "#address-#{@home.id}" do
        expect(page).to have_button("Delete Address")
      end
    end
  end
end
