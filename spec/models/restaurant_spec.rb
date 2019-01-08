require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
  subject {
    described_class.new(name: "Guest", email: "guest@example.com", phone: '0111234567')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with invalid email" do
    subject.email = 'test.domain.com'
    expect(subject).to_not be_valid
  end

  it "is valid with valid email" do
    subject.email = 'test@domain.com'
    expect(subject).to be_valid
  end

  it "is not valid with invalid phone" do
    subject.phone = '02121'
    expect(subject).to_not be_valid
  end

  it "is valid with invalid phone" do
    subject.phone = '0111234567'
    expect(subject).to be_valid
  end

  it "is not valid without name " do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without email " do
    subject.email = nil
    expect(subject).to_not be_valid
  end

end