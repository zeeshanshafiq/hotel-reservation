class ReservationMailer < ApplicationMailer

  def guest(reservation, update=false)
    @reservation = reservation
    @update = update
    mail(to: @reservation.guest.email, subject: "Reservation Details for #{@reservation.restaurant.name}")
  end

  def restaurant(reservation)
    @reservation = reservation
    mail(to: @reservation.restaurant.email, subject: "Reservation Details for #{@reservation.guest.name}")
  end
end