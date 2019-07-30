require "rails_helper"

RSpec.describe Address do
  describe "Relationships" do
    it {should have_many :orders}
    it {should belong_to :user}
  end

  describe "Validations" do
    it {should validate_presence_of :nickname}
    it {should validate_presence_of :street}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "Instance Methods" do
      it ".shipped_orders" do
        user = User.create!(name: 'Tay', email: 'tay.james@gmail.com', password: 'password')
        casita = user.addresses.create!(street: '2 LaHabre Dr.', city: "Pueblo", state: "CO", zip: 81005, nickname: "Mi Casita")
        order_1 = Order.create!(user: user, address_id: casita.id, status: "shipped")

        expect(casita.shipped_orders).to eq([order_1])
      end
  end
end
