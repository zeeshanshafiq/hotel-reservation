# == Schema Information
#
# Table name: reservations
#
#  id             :bigint(8)        not null, primary key
#  restaurant_id  :bigint(8)
#  table_id       :bigint(8)
#  shift_id       :bigint(8)
#  guest_id       :bigint(8)
#  guest_count    :integer
#  reservation_at :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Reservation < ApplicationRecord
  has_paper_trail
  belongs_to :restaurant
  belongs_to :table
  belongs_to :shift
  belongs_to :guest

  validates :guest_count, :reservation_at, presence: true
  validates_numericality_of :guest_count, :greater_than_or_equal_to => :min_table_capacity, :less_than_or_equal_to => :max_table_capacity

  validate :reservation_lies_in_shift
  validate :table_and_shift_belong_to_same_restaurant

  # after_create :send_emails
  # after_update :send_update_emails
  def min_table_capacity
    table.min_capacity
  end

  def max_table_capacity
    table.max_capacity
  end

  def reservation_time
    reservation_at.strftime("%I:%M %p")
  end

  def guest_name
    guest.name
  end

  def table_name
    table.name
  end

  private
  def send_update_emails
    ReservationMailer.guest(self, true).deliver_now
  end

  def send_emails
    ReservationMailer.guest(self).deliver_now
    ReservationMailer.restaurant(self).deliver_now
  end

  def reservation_lies_in_shift
    seconds_since_midnight = reservation_at.to_i % 86400
    errors.add(:reservation_at, 'does not lie within selected shift timings') if shift.start_at > seconds_since_midnight || shift.end_at < seconds_since_midnight
  end

  def table_and_shift_belong_to_same_restaurant
    errors.add(:base, 'table and shift must belong to same restaurant') unless table.restaurant_id == shift.restaurant_id
  end
end
