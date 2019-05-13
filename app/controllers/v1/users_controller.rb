class V1::UsersController < ApplicationController
  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_balance
    required_params = params.require(:user).permit(:balance)

    User.transaction do
      @user = User.lock.find(params[:id]) # lock record by id
      @user.balance = required_params[:balance]
      @user.save
    end

    if @user.valid?
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name)
    end
end
