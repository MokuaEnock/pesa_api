class SumsController < ApplicationController
  def index
    render json: Sum.all
  end

  def create
    sum = Sum.create(sum_params)
    render json: sum
  end

  def show
    sum = Sum.find(params[:id])
    render json: sum
  end
end
