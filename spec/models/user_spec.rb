require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:country) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:full_name) }

  it "generates a random token when a user is created" do
    boo = Fabricate(:user)
    expect(boo.token).to be_present
  end
end