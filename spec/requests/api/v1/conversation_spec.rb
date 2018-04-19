require 'rails_helper'

describe Conversation do 
  describe "creation" do
    before do
      let(:Creator){ User.create!(email: 'user1@test.com', password: 'test123', password_confirmation: 'test123',first_name: "Steve", last_name: "Richert") }
      let(:Volunteer){ User.create!(email: 'user2@test.com', password: 'test123', password_confirmation: 'test123',first_name: "Steve", last_name: "Richert") }
      let(:Task){Task.create!(title: "title",
        description: "task body",
        lat: 1,
        lng: 2,
        user_id: 1,
        task_type: "material",
      )} 
    end
    let(:Conversation){ Conversation.create!(task_id: 1)}
  end
end







