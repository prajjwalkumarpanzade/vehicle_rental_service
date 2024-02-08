class VehiclesController < ApplicationController

  def index
    if current_user.role == "admin"
      @vehicles = Vehicle.all      
      render json: @vehicles
    elsif current_user.role == "user"
      @vehicles = Vehicle.where(status: "available")
      render json: @vehicles
    else
      render json: {message: "You need to login first to view his page"}
    end
    
  end

  def new
  end
  
  def create
    if current_user.role == "admin"
      @vehicle = Vehicle.new(vehicle_params)
      if @vehicle.save
        render json: @vehicle
      else
        render json: @vehicle.errors
      end
    else
      render json: {message: "You need to login first with admin role to view this page"} 
    end
  end

  def update
    if current_user.role == "admin"
      @vehicle = vehicle_find
      if @vehicle.update(vehicle_params)
        render json: {message: "Vehicle updated successfully"}, status: 200
      else
        render json: @vehicle.errors, status: :unprocessable_entity
      end
    else
      render json: {message: "You need to login first with admin role to perform this action"}
    end
  end

  def destroy
    if current_user.role == "admin"
      @vehicle = vehicle_find
      if @vehicle.destroy
        render json: {message: "Vehicle deleted successfully"}, status: 200
      else
        render json: @vehicle.errors, status: :unprocessable_entity
      end
    else
      render json: {message: "You need to login first with admin role to perform this action"}
    end
  end


  private
  def vehicle_params
    params.require(:vehicle).permit(:v_type, :model, :price_per_hrs, :status, :make, :year, :fuel_type, :mileage, :vehicle_no)
  end
  def vehicle_find
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.nil?
      render json: {message: "Vehicle not found"}, status: 404
    end
  end
end
