class ReservationsController < ApplicationController
  before_action :load_restaurant, except: :index

  def index
    restaurant = Restaurant.eager_load(reservations: [:table, :guest]).find(params[:restaurant_id])
    render json: restaurant.reservations.as_json(methods: [:reservation_time,:guest_name, :table_name],
                                                 only: [:id, :guest_count])
  end

  def create
    @reservation = @restaurant.reservations.build(reservation_params)
    if @reservation.save
      render json: @reservation
    else
      render json: { errors: @reservation.errors.full_messages }, status: 422
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      head(:ok)
    else
      render json: { errors: @reservation.errors.full_messages }, status: 422
    end
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def reservation_params
    params.require(:reservation).permit(:table_id, :shift_id, :guest_id, :guest_count, :reservation_at)
  end
end
