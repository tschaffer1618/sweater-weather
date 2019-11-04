require 'rails_helper'

describe BackgroundImage do
  describe "relationships" do
    it {should belong_to :location}
  end
end
