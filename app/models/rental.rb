class Rental < ApplicationRecord
  before_save :lower_case
  after_create :total_bill_update, :update_vehicle_status
  before_save :update_vehicle_status_available
  belongs_to :user
  belongs_to :vehicle
  validates :user_id, presence: true
  validates :vehicle_id, presence: true
  validates :start_date, presence: true, comparison: { greater_than: Time.now, message: "must be after current time" }
  # validates :actual_end_date, comparison: { greater_than: :start_date, message: "must be after start date" }
  validates :expected_end_date, comparison: { greater_than: :start_date, message: "must be after start date" }
  validates :pickup_point, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :destination, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :expected_end_date, comparison: { greater_than: :start_date, message: "must be after start date" }
  
  def total_bill_calculate
    (((expected_end_date.to_time - start_date.to_time)))/1.hour * vehicle.price_per_hrs
  end
  def extra_cost_calculate
    if actual_end_date >=  Time.now
      ((actual_end_date.to_time - expected_end_date.to_time))/1.hour * vehicle.price_per_hrs
    end
  end

  private
    def total_bill_update
      update(total_bill: total_bill_calculate)
    end
    def update_vehicle_status
      update(extra_cost: extra_cost_calculate)
    end
    def update_vehicle_status_available
      vehicle.update!(status: 'available') if vehicle.present?
    end
    def lower_case
      self.pickup_point = self.pickup_point.downcase
      self.destination = self.destination.downcase
    end
end