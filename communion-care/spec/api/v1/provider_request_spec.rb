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

	# CREATE
	describe 'post /providers' do
		context 'when valid' do
			it 'creates a new JSON object and adds to collection' do

				post '/api/v1/providers', { provider: {name: 'Bad Sandy', skill: 'Peer Pressuring'}}
				provider = Provider.last
				response_body = JSON.parse(response.body)
	        	expect(response).to be_success
	        	expect(Provider.count).to eq(1)
	        	expect(provider.name).to eq('Bad Sandy')
	        	expect(provider.skill).to eq('Peer Pressuring')
	        	expect(response_body["name"]).to eq("Bad Sandy")
			end
		end

	  context 'when invalid' do 
      it 'returns an error status and message' do
       	
       	post '/api/v1/providers', { provider: {name: nil, skill: 'Peer Pressuring'}}
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(500)
        expect(response_body).to eq({"name" => ["can't be blank"]}) 
      end
    end
  end

	# UPDATE
	describe 'patch /providers' do
    context 'is valid' do 
			it 'updates a JSON object' do
				Provider.create(name: 'Bad Sandy', skill: 'Peer Pressuring')

				patch '/api/v1/providers/1', { provider: {name: 'Good Sandy', skill: 'Masochist Enabler'}}
				provider = Provider.last
				response_body = JSON.parse(response.body)
	        	expect(response).to be_success
	        	expect(Provider.count).to eq(1)
	        	expect(provider.name).to eq('Good Sandy')
	        	expect(provider.skill).to eq('Masochist Enabler')
	        	expect(response_body["name"]).to eq("Good Sandy")
		      end
				end

	  context 'is not valid' do 
      it 'returns an error status and message' do 
        Provider.create(name: 'Bad Sandy', skill: 'Peer Pressuring')
				patch '/api/v1/providers/1', { provider: {name: nil, skill: 'Masochist Enabler'}}
          expect(response.status).to eq(500)
          expect(JSON.parse(response.body)).to eq({"name" => ["can't be blank"]})
      end
    end
  end

	describe "destroy '/providers/:id'" do
		context 'it exists' do 
    	it 'destroys the provider record' do 
        	good_sandy = Provider.create(name: 'Good Sandy', skill: 'Masochist Enabler')
        	delete '/api/v1/providers/1'
       		expect(response).to be_success
        	expect(Provider.count).to eq(0)
      end
    end

    context 'it does not exist' do 
      it 'return an error message and a 404 status' do 
        delete '/api/v1/providers/1'
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)).to eq({"error" => "provider with id of 1 not found"})
      end
    end
  end
end