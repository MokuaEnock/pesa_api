class NumbersController < ApplicationController

  def index
    render json: Number.all
  end
end
