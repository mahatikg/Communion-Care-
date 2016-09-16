class Customer < ApplicationRecord
  has_many :appointments
  has_many :providers, through: :appointments
  validates :name, :interest, presence: true
end
