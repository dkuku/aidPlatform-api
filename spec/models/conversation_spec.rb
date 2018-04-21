require 'rails_helper'

describe Conversation, type: :model do
  
  it 'has a valid factory' do
    user1 = create(:user)
    user2 = create(:random_user)
    task1 = create(:task)
    expect(create(:conversation)).to be_valid
  end

  describe '#sender_id' do
    it { should validate_presence_of(:sender_id) }
  end
  describe '#task_id' do
    it { should validate_presence_of(:task_id) }
  end
end
