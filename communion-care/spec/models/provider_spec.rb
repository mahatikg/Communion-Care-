require 'rails_helper'

RSpec.describe Provider, type: :model do

before(:each) do
  @good_provider = Provider.create(name:'Mindy', skill:'Physical Therapy')
  @bad_provider = Provider.create(skill:'Poor Decision Making')
end

  describe 'Provider' do
    context 'when valid' do
      it 'has a name and exists' do
        expect(@good_provider).to be_valid
        expect(@good_provider.name).to eq('Mindy')
        expect(@bad_provider).to be_invalid
      end
    end
    context "when not valid" do
      it 'will not save' do
        expect(@bad_provider.errors[:name]).to include("can't be blank")
      end
    end
  end
end
