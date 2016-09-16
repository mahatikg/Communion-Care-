require 'rails_helper'

describe "Customers API" do

	# INDEX
	describe 'get /customers' do 
		it 'returns a JSON collection of all of the customers' do
				Customer.create(name:'Ben Affleck', interest:'Second String Fame')
  			Customer.create(name: 'Matt Damon', interest:'Reliving Jason Bourne Glory')
  			
  			get '/api/v1/customers'
  			response_body = JSON.parse(response.body)
  			expect(response).to be_success
      		expect(response_body.length).to eq(2)
      		expect(response_body.first["customers"]).to eq(nil)
      	end
	end

	# SHOW
	describe 'get /customers/1' do
		it 'returns a JSON object describing the first Customer' do
			customer = Customer.create(name:'Ben Affleck', interest:'Second String Fame')

			get '/api/v1/customers/1'
			response_body = JSON.parse(response.body)
			expect(response).to be_success
			expect(response_body["name"]).to eq(customer.name)
		end
	end

	# CREATE
	describe 'post /customers' do
		context 'when valid' do
			it 'creates a new JSON object and adds to collection' do

				post '/api/v1/customers', { customer: {name: 'Ben Affleck', interest: 'Second String Fame'}}
				customer = Customer.last
				response_body = JSON.parse(response.body)
	        	expect(response).to be_success
	        	expect(Customer.count).to eq(1)
	        	expect(customer.name).to eq('Ben Affleck')
	        	expect(customer.interest).to eq('Second String Fame')
	        	expect(response_body["name"]).to eq("Ben Affleck")
			end
		end

	  context 'when invalid' do 
      it 'returns an error status and message' do
       	
       	post '/api/v1/customers', { customer: {name: nil, interest: 'Second String Fame'}}
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(500)
        expect(response_body).to eq({"name" => ["can't be blank"]}) 
      end
    end
  end

	# UPDATE
	describe 'patch /customers' do
    context 'is valid' do 
			it 'updates a JSON object' do
				Customer.create(name:'Ben Affleck', interest:'Second String Fame')

				patch '/api/v1/customers/1', { customer: {name: 'Matt Damon', interest: 'Reliving Jason Bourne Glory'}}
				customer = Customer.last
				response_body = JSON.parse(response.body)
	        	expect(response).to be_success
	        	expect(Customer.count).to eq(1)
	        	expect(customer.name).to eq('Matt Damon')
	        	expect(customer.interest).to eq('Reliving Jason Bourne Glory')
	        	expect(response_body["name"]).to eq("Matt Damon")
		      end
				end

	  context 'is not valid' do 
      it 'returns an error status and message' do 
        Customer.create(name:'Ben Affleck', interest:'Second String Fame')
				patch '/api/v1/customers/1', { customer: {name: nil, interest: 'Reliving Jason Bourne Glory'}}
          expect(response.status).to eq(500)
          expect(JSON.parse(response.body)).to eq({"name" => ["can't be blank"]})
      end
    end
  end

	describe "destroy '/customers/:id'" do
		context 'it exists' do 
    	it 'destroys the customer record' do 
        	Customer.create(name:'Ben Affleck', interest:'Second String Fame')
        	delete '/api/v1/customers/1'
       		expect(response).to be_success
        	expect(Customer.count).to eq(0)
      end
    end

    context 'it does not exist' do 
      it 'return an error message and a 404 status' do 
        delete '/api/v1/customers/1'
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)).to eq({"error" => "customer with id of 1 not found"})
      end
    end
  end
end