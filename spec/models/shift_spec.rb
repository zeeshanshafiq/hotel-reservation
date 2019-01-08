require 'rails_helper'

RSpec.describe Shift, :type => :model do

  setup do
    @restaurant = create(:restaurant)
  end

  subject {
    described_class.new(name: "Morning", start_time: '09:00 am', end_time: '01:00 pm', restaurant: @restaurant)
  }


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "should convert time to second since midnight" do
    expect(subject.start_at).equal?(32400)
    expect(subject.end_at).equal?(46800)
  end

  it 'should be invalid without name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'end time cannot be less than start time' do
      subject.end_time = '08:00 am'
      expect(subject).to_not be_valid
  end

end