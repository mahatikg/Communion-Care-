require 'rails_helper'

RSpec.describe Customer, type: :model do

before(:each) do
  @good_customer = Customer.create(name:'Ben Affleck', interest:'Second String Fame')
  @bad_customer = Customer.create(interest:'Reliving Jason Bourne Glory')
end

  describe 'Customer' do
    context 'when valid' do
      it 'has a name and exists' do
        expect(@good_customer).to be_valid
        expect(@good_customer.name).to eq('Ben Affleck')
        expect(@bad_customer).to be_invalid
      end
    end
    context "when not valid" do
      it 'will not save' do
        expect(@bad_customer.errors[:name]).to include("can't be blank")
      end
    end
  end
end
