class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user
  end

  def destroy
  end

  private

  def user_params
    params.permit(:email, :username, :amount, :phone)
  end
end
