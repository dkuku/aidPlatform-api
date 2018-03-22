require 'rails_helper'

describe User do
  let(:user){ User.create!(email: 'user@test.com', password: 'test123', password_confirmation: 'test123',first_name: "Steve", last_name: "Richert") }

  context "#to_json" do
    it "includes required params" do
      params = %({"first_name":"Steve", "last_name":"Richert"})
#      expect(user.to_json).to include_json(params)
    end

    it "includes the ID" do
      expect(user.to_json).to have_json_path("id")
      expect(user.to_json).to have_json_type(Integer).at_path("id")
      expect(user.to_json).to have_json_path("authentication_token")
      expect(user.to_json).to have_json_type(String).at_path("authentication_token")
    end
  end
end
