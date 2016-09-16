class Appointment < ApplicationRecord
  belongs_to :provider
  belongs_to :customer
end
