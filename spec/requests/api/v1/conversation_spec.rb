require 'rails_helper'

describe Conversation do 
  context "creation" do
    it "returns all required parameters" do
      user1 = create(:user)
      user2 = create(:random_user)
      task1 = create(:task)
      conv = create(:conversation).to_json
      expect(conv).to have_json_path("sender_id")
      expect(conv).to have_json_type(Integer).at_path("sender_id")
      expect(conv).to have_json_path("task_id")
      expect(conv).to have_json_type(Integer).at_path("task_id")
    end
  end
end
