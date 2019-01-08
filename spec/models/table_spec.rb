require 'rails_helper'

RSpec.describe Table, :type => :model do

  setup do
    @restaurant = create(:restaurant)
  end

  subject {
    described_class.new(name: "Table1", min_capacity: 1, max_capacity: 10, restaurant: @restaurant)
  }


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it 'is invalid without name' do
    subject.name = nil
    expect(subject).to_not be_valid
    subject.name = 'Table1'
    expect(subject).to be_valid
  end

  it 'maximum capaicity should be greater than minimum capacity' do
    subject.max_capacity = 0
    expect(subject).to_not be_valid
    subject.max_capacity = 5
    expect(subject).to be_valid
  end
end