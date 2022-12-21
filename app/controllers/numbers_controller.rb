class NumbersController < ApplicationController
  def index
    render json: Number.all
  end

  def show
    num = Number.find(params[:id])
    render json: num
  end

  def create
    num = Number.create(num_params)
    render json: num
  end

  private

  def num_params
    params.permit(:numberA, :numberB)
  end
end
