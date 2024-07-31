class EngineersController < ApplicationController
  def index
    engineers = Engineer.all
    render json: engineers
  end

  def show
    engineer = Engineer.find(params[:id])
    render json: engineer
  end

  def create
    engineer = Engineer.new(engineer_params)
    if engineer.save
      render json: engineer, status: :created
    else
      render json: engineer.errors, status: :unprocessable_entity
    end
  end

  def update
    engineer = Engineer.find(params[:id])
    if engineer.update(engineer_params)
      render json: engineer
    else
      render json: engineer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    engineer = Engineer.find(params[:id])
    engineer.destroy
    head :no_content
  end

  private

  def engineer_params
    params.require(:engineer).permit(:name, :color)
  end
end
