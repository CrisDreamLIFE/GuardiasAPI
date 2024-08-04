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

  # def show_blocks_with_availability
  #   week = Week.find(params[:id])
  #   days = week.days.includes(blocks: :engineers)

  #   result = days.each_with_object({}) do |day, result_hash|
  #     result_hash[day.label] = day.blocks.each_with_object({}) do |block, block_hash|
  #       block_hash[block.id] = {
  #         engineers: block.engineers.map do |engineer|
  #           {
  #             name: engineer.name,
  #             available: engineer.blocks.include?(block)
  #           }
  #         end
  #       }
  #     end
  #   end

  #   render json: result
  # end
  # def show_blocks_with_availability
  #   week = Week.find(params[:id])
  #   days = week.days.includes(:blocks)
  
  #   result = days.each_with_object({}) do |day, result_hash|
  #     result_hash[day.label] = day.blocks.each_with_object({}) do |block, block_hash|
  #       block_hash[block.id] = {
  #         engineers: block.available_engineers
  #       }
  #     end
  #   end
  
  #   render json: result
  # end
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

  private

  def week_params
    params.require(:week).permit(:label, :start_date, :end_date, :service_id, :number, :year)
  end
end
