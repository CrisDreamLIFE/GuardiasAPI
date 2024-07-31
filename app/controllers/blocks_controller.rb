class BlocksController < ApplicationController
  def index
    blocks = Block.all
    render json: blocks
  end

  def show
    block = Block.find(params[:id])
    render json: block
  end

  def create
    block = Block.new(block_params)
    if block.save
      render json: block, status: :created
    else
      render json: block.errors, status: :unprocessable_entity
    end
  end

  def update
    block = Block.find(params[:id])
    if block.update(block_params)
      render json: block
    else
      render json: block.errors, status: :unprocessable_entity
    end
  end

  def destroy
    block = Block.find(params[:id])
    block.destroy
    head :no_content
  end

  private

  def block_params
    params.require(:block).permit(:time, :day_id, :engineer_id)
  end
end
