class Location < ApplicationRecord
  has_one :background_image

  validates_presence_of :address
end
