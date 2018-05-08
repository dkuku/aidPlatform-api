require 'rails_helper'

describe Message, type: :model do
  
  it 'has a valid factory' do
    user1 = create(:user)
    user2 = create(:random_user)
    task1 = create(:task)
    conv1 = create(:conversation)
    expect(create(:message)).to be_valid

  end

  describe '#volunteer_id' do
    it { should validate_presence_of(:volunteer_id) }
  end
  describe '#task_owner_id' do
    it { should validate_presence_of(:task_owner_id) }
  end
  describe '#conversation_id' do
    it { should validate_presence_of(:conversation_id) }
  end
  describe '#body' do
    it { should validate_presence_of(:body) }
  end
end
