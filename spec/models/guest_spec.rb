require 'rails_helper'

RSpec.describe Guest, :type => :model do
  subject {
    described_class.new(name: "Guest", email: "guest@example.com")
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

  it "is not valid without name " do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without email " do
    subject.email = nil
    expect(subject).to_not be_valid
  end

end