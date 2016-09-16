class Provider < ApplicationRecord
  has_many :appointments
  has_many :customers, through: :appointments
  validates :name, :skill,  presence: true 

end
