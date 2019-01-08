# == Schema Information
#
# Table name: tables
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  min_capacity  :integer
#  max_capacity  :integer
#  restaurant_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Table < ApplicationRecord

  belongs_to :restaurant

  validates :name, :min_capacity, :max_capacity, presence: true
  validates :min_capacity, :max_capacity, numericality: { only_integer: true, greater_than: 0 }
  validate :table_capacity, if: ->(t) { t.max_capacity.present? && t.min_capacity.present? }

  private

  def table_capacity
    errors.add(:max_capacity, 'cannot be less than minimum_capacity') if max_capacity < min_capacity
  end

end
