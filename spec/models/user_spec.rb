require 'rails_helper'

describe User, type: :model do
  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end

  describe '#first_name' do
    it { should validate_presence_of(:first_name) }
  end
  describe '#last_name' do
    it { should validate_presence_of(:last_name) }
  end

  describe '#email' do
    it { should validate_presence_of(:email) }
    it { should_not allow_value("sasa").for(:email) }
    it { should allow_value("email@sa.pl").for(:email) }

  end
  describe '#password' do
    it { should validate_presence_of(:password) }
    it { should_not allow_value("").for(:password) }
    it { should_not allow_value("sasa").for(:password) }
  end
end
