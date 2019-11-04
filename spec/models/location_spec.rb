require 'rails_helper'

describe Location do
  describe "relationships" do
    it {should have_one :background_image}
  end
end
