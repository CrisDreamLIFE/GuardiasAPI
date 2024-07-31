class AvailabilitiesController < ApplicationController
    def index
        availabilities = Availability.all
        render json: availabilities
      end
    
      def show
        availability = Availability.find(params[:id])
        render json: availability
      end
    
      def create
        availability = Availability.new(availability_params)
        if availability.save
          render json: availability, status: :created
        else
          render json: availability.errors, status: :unprocessable_entity
        end
      end
    
      def update
        availability = Availability.find(params[:id])
        if availability.update(availability_params)
          render json: availability
        else
          render json: availability.errors, status: :unprocessable_entity
        end
      end
    
      def destroy
        availability = Availability.find(params[:id])
        availability.destroy
        head :no_content
      end
    
      private
    
      def availability_params
        params.require(:availability).permit(:engineer_id, :block_id)
      end
end
