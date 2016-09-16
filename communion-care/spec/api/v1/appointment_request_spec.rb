require 'rails_helper'

describe "Appointments API" do

	# INDEX
	describe 'get /appointments' do 
		it 'returns a JSON collection of all of the appointments' do
			Customer.create(name:'Ben Affleck', interest:'Second String Fame')
			Customer.create(name: 'Matt Damon', interest:'Reliving Jason Bourne Glory')
			Provider.create(name:'Mindy', skill:'Physical Therapy')
			Provider.create(name: 'Cindy', skill:'Poor Decision Making')
			Appointment.create(date_time:'September 20th', location:'Hollywood', provider_id: 1, customer_id: 1)
			Appointment.create(date_time: 'September 21st', location:'Boston', provider_id: 2, customer_id: 2)
			
			get '/api/v1/appointments'
			response_body = JSON.parse(response.body)
			expect(response).to be_success
    		expect(response_body.length).to eq(2)
    		expect(response_body.first["appointments"]).to eq(nil)
  	end
	end

	# SHOW
	describe 'get /appointments/1' do
		it 'returns a JSON object describing the first Appointment' do
			Customer.create(name:'Ben Affleck', interest:'Second String Fame')
			Provider.create(name:'Mindy', skill:'Physical Therapy')
			appointment = Appointment.create(date_time:'September 20th', location:'Hollywood', provider_id: 1, customer_id: 1)

			get '/api/v1/appointments/1'
			response_body = JSON.parse(response.body)
			expect(response).to be_success
			expect(response_body["date_time"]).to eq(appointment.date_time)
		end
	end

	# CREATE
	describe 'post /appointments' do
		context 'when valid' do
			it 'creates a new JSON object and adds to collection' do
				Customer.create(name:'Ben Affleck', interest:'Second String Fame')
				Provider.create(name:'Mindy', skill:'Physical Therapy')

				post '/api/v1/appointments', { appointment: {date_time:'September 20th', location:'Hollywood', provider_id: 1, customer_id: 1}}
				appointment = Appointment.last
				response_body = JSON.parse(response.body)
	      	expect(response).to be_success
	      	expect(Appointment.count).to eq(1)
	      	expect(appointment.date_time).to eq('September 20th')
	      	expect(appointment.location).to eq('Hollywood')
	      	expect(response_body["date_time"]).to eq("September 20th")
			end
		end

	  context 'when invalid' do 
      it 'returns an error status and message' do
      	Customer.create(name:'Ben Affleck', interest:'Second String Fame')
				Provider.create(name:'Mindy', skill:'Physical Therapy')
       	
       	post '/api/v1/appointments', { appointment: {date_time: nil, location: 'Hollywood', provider_id: 1, customer_id: 1}}
        response_body = JSON.parse(response.body)
        expect(response.status).to eq(500)
        expect(response_body).to eq({"date_time" => ["can't be blank"]}) 
      end
    end
  end

	# UPDATE
	describe 'patch /appointments' do
    context 'is valid' do 
			it 'updates a JSON object' do
				Customer.create(name:'Ben Affleck', interest:'Second String Fame')
				Provider.create(name:'Mindy', skill:'Physical Therapy')
				Appointment.create(date_time:'September 20th', location:'Hollywood', provider_id: 1, customer_id: 1)

				patch '/api/v1/appointments/1', { appointment: { date_time:'September 21st', location:'Boston', provider_id: 1, customer_id: 1 }}
				appointment = Appointment.last
				response_body = JSON.parse(response.body)
        	expect(response).to be_success
        	expect(Appointment.count).to eq(1)
        	expect(appointment.date_time).to eq('September 21st')
        	expect(appointment.location).to eq('Boston')
        	expect(response_body["date_time"]).to eq("September 21st")
	      end
			end

	  context 'is not valid' do 
      it 'returns an error status and message' do 
        Customer.create(name:'Ben Affleck', interest:'Second String Fame')
				Provider.create(name:'Mindy', skill:'Physical Therapy')
        Appointment.create(date_time:'September 20th', location:'Hollywood', provider_id: 1, customer_id: 1)
				
				patch '/api/v1/appointments/1', { appointment: {date_time: nil, location:'Boston', provider_id: 1, customer_id: 1}}
          expect(response.status).to eq(500)
          expect(JSON.parse(response.body)).to eq({"date_time" => ["can't be blank"]})
      end
    end
  end

	describe "destroy '/appointments/:id'" do
		context 'it exists' do 
    	it 'destroys the appointment record' do 
      	Customer.create(name:'Ben Affleck', interest:'Second String Fame')
				Provider.create(name:'Mindy', skill:'Physical Therapy')
      	Appointment.create(date_time:'September 20th', location:'Hollywood', provider_id: 1, customer_id: 1)
      	
      	delete '/api/v1/appointments/1'
     		expect(response).to be_success
      	expect(Appointment.count).to eq(0)
      end
    end

    context 'it does not exist' do 
      it 'return an error message and a 404 status' do 
        
        delete '/api/v1/appointments/1'
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)).to eq({"error" => "appointment with id of 1 not found"})
      end
    end
  end
end