require 'rails_helper'

describe Task, type: :model do
  
  it 'has a valid factory' do
    @user = create(:user)
    expect(create(:task)).to be_valid
  end

  describe '#title' do
    it { should validate_presence_of(:title) }
  end
  describe '#description' do
    it { should validate_presence_of(:description) }
  end

  describe '#lat' do
    it { should validate_presence_of(:lat) }
    it { should_not allow_value(100).for(:lat) }
    it { should allow_value(51).for(:lat) }
  end
  describe '#lng' do
    it { should validate_presence_of(:lng) }
    it { should_not allow_value(100).for(:lng) }
    it { should allow_value(0).for(:lng) }
  end
  describe '#task_type' do
    it { should validate_presence_of(:task_type) }
    it { should_not allow_value("sasa").for(:task_type) }
    it { should allow_value("help").for(:task_type) }
    it { should allow_value("material").for(:task_type) }

  end
end
