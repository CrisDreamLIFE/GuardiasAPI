class DaysController < ApplicationController
  def index
    days = Day.all
    render json: days
  end

  def show
    day = Day.find(params[:id])
    render json: day
  end

  def create
    day = Day.new(day_params)
    if day.save
      render json: day, status: :created
    else
      render json: day.errors, status: :unprocessable_entity
    end
  end

  def update
    day = Day.find(params[:id])
    if day.update(day_params)
      render json: day
    else
      render json: day.errors, status: :unprocessable_entity
    end
  end

  def destroy
    day = Day.find(params[:id])
    day.destroy
    head :no_content
  end

  private

  def day_params
    params.require(:day).permit(:label, :week_id)
  end
end
