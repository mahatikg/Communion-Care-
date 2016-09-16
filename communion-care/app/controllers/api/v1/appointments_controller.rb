module Api
	module V1
	    class AppointmentsController < ApplicationController

	    	def index
	    		render json: Appointment.all
	    	end

	    	def create
	    		# binding.pry
		        appointment = Appointment.new(appointment_params)
		        if appointment.save
		          render json: appointment
		        else
		          render json: appointment.errors, status: 500
		        end
		    end

		    def show
		    	render json: Appointment.find(params[:id])
		    end

		    def update
	    		# binding.pry
		        appointment = Appointment.find(params[:id])
		        if appointment.update(appointment_params)
		          render json: appointment
		        else
		          render json: appointment.errors, status: 500
		        end
		    end

		    def destroy
		        appointment = Appointment.find_by(id: params[:id])
		        if appointment
		          appointment.destroy
		          head :ok
		        else
		          render json: {"error" => "appointment with id of #{params[:id]} not found"}, status: 404
		        end
		    end

		    private

		    def appointment_params
		    	params.require(:appointment).permit(:date_time, :location, :provider_id, :customer_id)
		    end

	    end
	end
end
