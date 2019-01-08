# == Schema Information
#
# Table name: restaurants
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Restaurant < ApplicationRecord

  validates :name, :email, :phone, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, if: :email_changed?
  validates_format_of :phone, with: /(\+?6?01)[0-46-9]-*[0-9]{7,8}/, if: :phone_changed?

  has_many :shifts
  has_many :tables
  has_many :reservations

end
