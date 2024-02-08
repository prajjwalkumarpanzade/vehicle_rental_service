class Vehicle < ApplicationRecord
  before_save :lower_case
  has_many :rentals
  enum v_type: %w(car bike jeep).index_with(&:to_s)
  enum fuel_type: %w(petrol diesel electric CNG).index_with(&:to_s)
  enum status: %w(available booked).index_with(&:to_s)
  validates :model, presence: true
  validates :make, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 2015, less_than_or_equal_to: Date.current.year, message: "must be a year between 2015 and #{Date.current.year}" }
  validates :vehicle_no, presence: true, uniqueness: true
  validates :price_per_hrs, presence: true
  validates :mileage, presence: true
  
  private
    def lower_case
      self.model = self.model.downcase
      self.make = self.make.downcase 
      self.vehicle_no = self.vehicle_no.downcase
    end
end
