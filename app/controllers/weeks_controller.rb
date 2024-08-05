class WeeksController < ApplicationController
  def index
    weeks = Week.all
    render json: weeks
  end

  def getWeeksByService
    service = Service.find(params[:id])
    weeks = service.weeks

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

    result = getBlocks_with_engineer(params[:id])
  
    render json: result, status: :ok
    # render json: { message: 'Shift assignment completed successfully' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Week not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show_blocks_with_availability
    week = Week.find(params[:id])
    days = week.days.includes(:blocks, blocks: :availabilities)
  
    result = {
      days: days.map do |day|
        {
          id: day.id,
          label: day.label,
          week_id: day.week_id,
          blocks: day.blocks.map do |block|
            {
              id: block.id,
              start_time: block.start_time,
              end_time: block.end_time,
              day_id: block.day_id,
              engineers: block.available_engineers
            }
          end
        }
      end
    }
  
    render json: result
  end

  def show_blocks_with_summary
    week = Week.find(params[:id])
    days = week.days.includes(:blocks, blocks: :availabilities)
  
    result = {
      summary: week.summary_engineers,
      days: days.map do |day|
        {
          id: day.id,
          label: day.label,
          blocks: day.blocks.map do |block|
            {
              id: block.id,
              start_time: block.start_time,
              end_time: block.end_time,
              engineer: block.engineer
            }
          end
        }
      end
    }
  
    render json: result
  end

  def show_blocks_with_engineer
    result = getBlocks_with_engineer(params[:id])
  
    render json: result
  end

  private

  def getBlocks_with_engineer(id)
    week = Week.find(id)
    days = week.days.includes(:blocks, blocks: :availabilities)
  
    result = {
      days: days.map do |day|
        {
          id: day.id,
          label: day.label,
          week_id: day.week_id,
          blocks: day.blocks.map do |block|
            {
              id: block.id,
              engineer_id: block.engineer_id,
              start_time: block.start_time,
              end_time: block.end_time,
              day_id: block.day_id,
              engineers: Engineer.all
            }
          end
        }
      end
    }
  end

  def week_params
    params.require(:week).permit(:label, :start_date, :end_date, :service_id, :number, :year)
  end
end
