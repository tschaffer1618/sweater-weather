require 'rails_helper'

describe Location do
  describe "relationships" do
    it {should have_one :background_image}
  end

  describe "validations" do
    it {should validate_presence_of :address}
  end
end
