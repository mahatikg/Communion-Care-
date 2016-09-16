module Api
	module V1
	    class CustomersController < ApplicationController

	    	def index
	    		render json: Customer.all
	    	end

	    	def create
	    		# binding.pry
		        customer = Customer.new(customer_params)
		        if customer.save
		          render json: customer
		        else
		          render json: customer.errors, status: 500
		        end
		    end

		    def show
		    	render json: Customer.find(params[:id])
		    end

		    def update
	    		# binding.pry
		        customer = Customer.find(params[:id])
		        if customer.update(customer_params)
		          render json: customer
		        else
		          render json: customer.errors, status: 500
		        end
		    end

		    def destroy
		        customer = Customer.find_by(id: params[:id])
		        if customer
		          customer.destroy
		          head :ok
		        else
		          render json: {"error" => "customer with id of #{params[:id]} not found"}, status: 404
		        end
		    end

		    private

		    def customer_params
		    	params.require(:customer).permit(:name, :interest)
		    end

	    end
	end
end
