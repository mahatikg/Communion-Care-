module Api
	module V1
	    class ProvidersController < ApplicationController

	    	def index
	    		render json: Provider.all
	    	end

	    	def create
	    		# binding.pry
		        provider = Provider.new(provider_params)
		        if provider.save
		          render json: provider
		        else
		          render json: provider.errors, status: 500
		        end
		    end

		    def show
		    	render json: Provider.find(params[:id])
		    end

		    def update
	    		# binding.pry
		        provider = Provider.find(params[:id])
		        if provider.update(provider_params)
		          render json: provider
		        else
		          render json: provider.errors, status: 500
		        end
		    end

		    def destroy
		        provider = Provider.find_by(id: params[:id])
		        if provider
		          provider.destroy
		          head :ok
		        else
		          render json: {"error" => "provider with id of #{params[:id]} not found"}, status: 404
		        end
		    end

		    private

		    def provider_params
		    	params.require(:provider).permit(:name, :skill)
		    end

	    end
	end
end
