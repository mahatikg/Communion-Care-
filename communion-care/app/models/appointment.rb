class Appointment < ApplicationRecord
  belongs_to :provider
  belongs_to :customer
  validates :date_time, :location, presence: true
end
