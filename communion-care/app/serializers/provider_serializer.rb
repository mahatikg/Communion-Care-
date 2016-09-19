class ProviderSerializer < ActiveModel::Serializer
  attributes :name, :skill
  has_many :appointments
end
