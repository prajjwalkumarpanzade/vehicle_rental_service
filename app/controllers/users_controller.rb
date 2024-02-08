class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def create 
    user = User.new(user_params)
    if user.save
      @token = encode_token(user_id: user.id)
      render json: {
          user: UserSerializer.new(user), 
          token: @token
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    if current_user.role == "admin"
      @users = User.all
      render json: @users
    else
      render json: {message: "You are not authorized to view this page"}
    end
  end
  
  def update
    if current_user.role == "user"
        @user = User.find_by(id: params[:id])
      if @user
        if @user.update(user_params)
          render json: @user,  message: 'User successfully updated.' , status: 200
        else
          render json: { message: 'You can not update other users profile' }, status: 400
        end
      else
        render json:{message: "User not found"}, status: 404
      end
    else
      render json: {message: "You are not authorized to perform this action"}
    end
  end

  def show 
    if current_user.role == "user"
      @user = User.find_by(id: params[:id])
      if @user == current_user
        render json: @user
      else
        render json:{message: "User not found"}, status: 404
      end
    elsif current_user.role == "admin"
      @user = User.find_by(id: params[:id])
      if @user == current_user
        render json: @user
      else
        render json:{message: "User not found"}, status: 404
      end
    else
      render json: {message: "You are not authorized to perform this action"}
    end
  end

  private

  def user_params 
      params.require(:user).permit(:name, :password, :address, :email, :phone_no, :role, :d_license_no)
  end

  def handle_invalid_record(e)
          render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
