require 'rails_helper'

RSpec.describe Reservation, :type => :model do

  setup do
    @restaurant = create(:restaurant)
    @tables = create_list(:table, 2, restaurant: @restaurant)
    @shift = create(:shift, restaurant: @restaurant)
    @guests = create_list(:guest, 3)
  end

  subject {
    described_class.new(restaurant: @restaurant, table: @tables[0], shift: @shift, guest: @guests[0], guest_count: 2, reservation_at: '10:00 am')
  }


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  #
  it 'guest count should be in table capacity' do
    subject.guest_count = 11
    expect(subject).to_not be_valid
    subject.guest_count = 8
    expect(subject).to be_valid
  end

  it 'reservation time should be in shift timing' do
    subject.reservation_at = '06:00 pm'
    expect(subject).to_not be_valid
    subject.reservation_at = '11:00 am'
    expect(subject).to be_valid
  end

  it 'should send 2 emails after create' do
    ActionMailer::Base.deliveries = []
    subject.save
    emails = ActionMailer::Base.deliveries
    expect(emails.length).equal?(2)
  end
end