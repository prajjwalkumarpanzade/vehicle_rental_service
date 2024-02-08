class RentalsController < ApplicationController
  def index 
    if current_user.role == "admin"
      @rentals = Rental.all
      render json: @rentals
    elsif current_user.role == "user"
      @rentals = Rental.where(user_id: current_user.id)
      render json: @rentals
    else
      render json: {message: "You need to login first to view this page"}
    end
  end


  def new
  end

  def create
    if current_user.role == "user"
      @vehicle = Vehicle.find_by(id: rental_params[:vehicle_id])
      @rental = Rental.new(rental_params)
      @rental.user_id = current_user.id
      @rental.vehicle_id = @vehicle.id
      if @rental.save
        render json: @rental
      else
        render json: {message: @rental.errors.full_messages}  
      end
    else
      render json: {message: "You need to login first with user role to perform this action"}
    end
  end

    private

    def rental_params
      params.require(:rental).permit(:destination, :start_date, :expected_end_date, :pickup_point, :vehicle_id)
    end



end
