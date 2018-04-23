describe Message do 
  context "creation" do
    it "returns all required parameters" do
      user1 = create(:user)
      user2 = create(:random_user)
      task1 = create(:task)
      conv = create(:conversation)
      message = create(:message).to_json
      expect(message).to have_json_path("volunteer_id")
      expect(message).to have_json_type(Integer).at_path("volunteer_id")
      expect(message).to have_json_path("task_owner_id")
      expect(message).to have_json_type(Integer).at_path("task_owner_id")
      expect(message).to have_json_path("conversation_id")
      expect(message).to have_json_type(Integer).at_path("conversation_id")
      expect(message).to have_json_path("body")
      expect(message).to have_json_type(String).at_path("body")
    end
  end
