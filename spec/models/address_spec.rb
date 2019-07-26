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
end
