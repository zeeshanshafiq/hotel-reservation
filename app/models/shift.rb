# == Schema Information
#
# Table name: shifts
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  start_at      :integer
#  end_at        :integer
#  restaurant_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Shift < ApplicationRecord

  attr_accessor :start_time, :end_time

  validates :name, :start_at, :end_at, presence: true
  validate :shift_timing

  before_validation :set_shift_timings

  belongs_to :restaurant

  def start
    Time.at(start_at).strftime("%I:%M%p")
  end

  def end
    Time.at(end_at).strftime("%I:%M%p")
  end

  private

  def set_shift_timings
    self.start_at = start_time.to_datetime.seconds_since_midnight if start_time.present?
    self.end_at = end_time.to_datetime.seconds_since_midnight if end_time.present?
  end

  def shift_timing
    errors.add(:base, 'end time cannot be less than start time') if end_at < start_at
  end

end
