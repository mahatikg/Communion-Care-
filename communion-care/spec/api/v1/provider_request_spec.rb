require 'rails_helper'

describe "Providers API" do

	# INDEX
	describe 'get /providers' do 
		it 'returns a JSON collection of all of the providers' do
			Provider.create(name:'Mindy', skill:'Physical Therapy')
  			Provider.create(name: 'Cindy', skill:'Poor Decision Making')
  			
  			get '/api/v1/providers'
  			response_body = JSON.parse(response.body)
  			expect(response).to be_success
      		expect(response_body.length).to eq(2)
      		expect(response_body.first["customers"]).to eq(nil)
      	end
	end

	# SHOW
	describe 'get /providers/1' do
		it 'returns a JSON object describing the first Provider' do
			provider = Provider.create(name: 'Mindy', skill: 'Physical Therapy')

			get '/api/v1/providers/1'
			response_body = JSON.parse(response.body)
			expect(response).to be_success
			expect(response_body["name"]).to eq(provider.name)
		end
	end


end