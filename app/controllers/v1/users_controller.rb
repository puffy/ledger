class V1::UsersController < ApplicationController
  INDEX_LIMIT = 50

  # GET /users
  def index
    @users = User.order(:id).limit(INDEX_LIMIT).offset(offset)
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

  def operations
    @user = User.find(params[:id])
    @operations = @user.operations.order(:created_at).limit(INDEX_LIMIT).offset(offset)
    render json: {'user' => @user.as_json(only: [:id, :name])}.
      merge('operations' => @operations.as_json)
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

    def page
      @page ||= params[:page].to_i
    end

    def offset
      @offset ||= page > 1 ? (page - 1) * INDEX_LIMIT : 0
    end
end
