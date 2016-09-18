class CustomerSerializer < ActiveModel::Serializer
  attributes :name, :interest
  has_many :appointments
end
