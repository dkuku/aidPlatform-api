require 'rails_helper'

describe User do
  let(:user){ User.create!(email: 'user@test.com', password: 'test123', password_confirmation: 'test123',first_name: "Steve", last_name: "Richert") }

  context "#to_json" do
    it "includes required params" do
      params = %({"email":"user@test.com", "first_name":"Steve", "last_name":"Richert"})
      expect(user.to_json).to be_json_eql(params).excluding("authentication_token", 'picture_content_type', 'picture_file_name', 'picture_file_size', 'picture_updated_at')
    end

    it "includes the ID" do
      expect(user.to_json).to have_json_path("id")
      expect(user.to_json).to have_json_type(Integer).at_path("id")
    end
    it "includes the token" do
      expect(user.to_json).to have_json_path("authentication_token")
      expect(user.to_json).to have_json_type(String).at_path("authentication_token")
    end
  end
end

describe 'Remote api request to sign_up' do
  it 'should create user' do
    user =  {:user => {:email => 'user@test.com', :password => 'test123', :password_confirmation => 'test123', :first_name => "Steve", :last_name => "Richert"} }
    post '/api/v1/sign_up', :params => user
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json["messages"]).to eq("Signed Up successfully")
    expect(json["is_success"]).to eq(true)
    expect(json["data"].keys).to contain_exactly('user')
    expect(json["data"]["user"].keys).to contain_exactly('id', 'created_at', 'updated_at', 'first_name', 'last_name', 'email','authentication_token','picture_content_type', 'picture_file_name', 'picture_file_size', 'picture_updated_at')
    expect(json["data"]["user"]["first_name"]).to eq("Steve")
    expect(json["data"]["user"]["last_name"]).to eq("Richert")
    expect(json["data"]["user"]["email"]).to eq("user@test.com")
    expect(json["data"]["user"]["authentication_token"]).to be_a(String)
  end
end
describe 'Remote api request to sign_in' do
  it 'should return user data' do
    user =  {:user => {:email => 'user@test.com', :password => 'test123', :password_confirmation => 'test123', :first_name => "Steve", :last_name => "Richert"} }
    post '/api/v1/sign_up', :params => user
    expect(response).to have_http_status(200)
    authentication_token = JSON.parse(response.body)["data"]["user"]["authentication_token"]
    post '/api/v1/sign_in', :params => {:sign_in => { :email => 'user@test.com', :password => 'test123'} }
    expect(response).to have_http_status(200)
  end
end  








