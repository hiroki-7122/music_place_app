class User < ApplicationRecord
  #validates :latitude, presence: true
  #validates :longitude, presence: true
  validates :address, presence: true
  validates :address, uniqueness: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
