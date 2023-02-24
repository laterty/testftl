class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      render json: {status: "SUCCESS", message: "Reservation was successfully created!", data: @reservation}, status: :ok
    else
      render json: { error: 'Oops! Reservation was not created.' }, status: 406
    end
  end

  private

  def reservation_params
    table = ::TableChooserService.new(permited_params).call
    { table_id: table&.id, start_time: permited_params[:start_time].to_time,
      end_time: permited_params[:end_time].to_time }
  end

  def permited_params
    params.require(:reservation).permit(:count_people, :start_time, :end_time)
  end
end
