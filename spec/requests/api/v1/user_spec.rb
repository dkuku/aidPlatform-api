require 'rails_helper'
describe User do

  context "create" do

    it "returns all required parameters" do
      user = create(:user).to_json
      expect(user).to have_json_path("id")
      expect(user).to have_json_type(Integer).at_path("id")
      expect(user).to have_json_path("authentication_token")
      expect(user).to have_json_type(String).at_path("authentication_token")
      expect(user).to have_json_path("first_name")
      expect(user).to have_json_type(String).at_path("first_name")
      expect(user).to have_json_path("last_name")
      expect(user).to have_json_type(String).at_path("last_name")
      expect(user).to have_json_path("email")
      expect(user).to have_json_type(String).at_path("email")
    end
  end
end

describe 'Remote api request to sign_up' do
  it 'should create user' do
    user = attributes_for(:user)
    post '/api/v1/sign_up', :params => {user: user}
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json["messages"]).to eq("Signed Up successfully")
    expect(json["is_success"]).to eq(true)
    expect(json["data"].keys).to contain_exactly('user')
    expect(json["data"]["user"].keys).to contain_exactly('id',
      'created_at', 'updated_at', 'first_name', 'last_name', 'email', 'authentication_token',
      "picture_content_type", "picture_file_size", "picture_file_name", "picture_updated_at")
    expect(json["data"]["user"]["first_name"]).to eq("John")
    expect(json["data"]["user"]["last_name"]).to eq("Smith")
    expect(json["data"]["user"]["email"]).to eq("john@test.com")
    expect(json["data"]["user"]["authentication_token"]).to be_a(String)
  end
end
describe 'Remote api request to sign_in' do
  it 'after successfull login it should return user data' do
    user = create(:user).to_json
    params =  {sign_in: {email: "John@test.com" , password: "123456"}}
    post '/api/v1/sign_in', :params =>  params
    json = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(json["is_success"]).to eq(true)
    expect(JSON.generate(json["data"]["user"])).to be_json_eql(user)
  end
end  
