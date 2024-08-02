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

    algorithm = GreedyAssignmentAlgorithm.new(week, engineers)
    algorithm.assign

    render json: { message: 'Shift assignment completed successfully' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Week not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def week_params
    params.require(:week).permit(:label, :start_date, :end_date, :service_id, :number, :year)
  end
end
