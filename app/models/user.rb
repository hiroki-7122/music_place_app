class User < ApplicationRecord
  #validates :latitude, presence: true
  #validates :longitude, presence: true
  #validates :latitude, uniqueness: true
  #validates :longitude, uniqueness: true
  geocoded_by :address
  after_validation :geocode
end
