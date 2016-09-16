module Api
	module V1
	    class ProvidersController < ApplicationController

	    	def index
	    		render json: Provider.all
	    	end

	    	def create
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

		    private

		    def provider_params
		    	params.require(:provider).permit(:name, :skill)
		    end

	    end
	end
end
