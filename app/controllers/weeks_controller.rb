class WeeksController < ApplicationController
    def index
        weeks = Week.all
        render json: weeks
      end
    
      def show
        week = Week.find(params[:id])
        render json: week
      end
    
      def create
        week = Week.new(week_params)
        if week.save
          render json: week, status: :created
        else
          render json: week.errors, status: :unprocessable_entity
        end
      end
    
      def update
        week = Week.find(params[:id])
        if week.update(week_params)
          render json: week
        else
          render json: week.errors, status: :unprocessable_entity
        end
      end
    
      def destroy
        week = Week.find(params[:id])
        week.destroy
        head :no_content
      end
    
      def assign_shifts
        week = Week.find(params[:id])
        engineers = Engineer.all
    
        AssignmentAlgorithm.new([week], engineers).assign
    
        render json: { message: 'Shifts assigned successfully' }
      end
    
      private
    
      def week_params
        params.require(:week).permit(:label, :start_date, :end_date, :service_id)
      end
end
