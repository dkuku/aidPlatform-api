require 'rails_helper'

describe Conversation do 
  context "creation" do
    it "returns all required parameters" do
      user1 = create(:user)
      user2 = create(:random_user)
      task1 = create(:task)
      conv = create(:conversation).to_json
      expect(conv).to have_json_path("volunteer_id")
      expect(conv).to have_json_type(Integer).at_path("volunteer_id")
      expect(conv).to have_json_path("task_owner_id")
      expect(conv).to have_json_type(Integer).at_path("task_owner_id")
      expect(conv).to have_json_path("task_id")
      expect(conv).to have_json_type(Integer).at_path("task_id")
    end
  end
end

describe 'Remote api request to conversation' do
  it 'should not allow to create task when unauthenticated' do

    conversation = attributes_for(:conversation)
    post '/api/v1/conversations', :params => {conversation: conversation}
    expect(response).to have_http_status(401)
    json = JSON.parse(response.body)
    expect(json["messages"]).to eq("Unauthenticated")
    expect(json["is_success"]).to eq(false)
  end

 it 'should not allow to reply on own request' do
    user1 = create(:user).to_json
    user2 = create(:random_user).to_json
    task1 = create(:task)
    conversation = attributes_for(:conversation)
    token = JSON.parse(user1)["authentication_token"]
    headers = {'AUTH-TOKEN': token}
    post '/api/v1/conversations', :params => {conversation: conversation}, :headers => headers
    expect(response).to have_http_status(422)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json["messages"]).to eq("You can't volunteer on your own request")
 end

  it 'should create conversation when proper header is send' do
    user1 = create(:user).to_json
    user2 = create(:random_user).to_json
    task1 = create(:task)
    conversation = attributes_for(:conversation)
    token = JSON.parse(user2)["authentication_token"]
    headers = {'AUTH-TOKEN': token}
    post '/api/v1//conversations', :params => {conversation: conversation}, :headers => headers
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json["messages"]).to eq("You can now contact the task Creator")

    post '/api/v1/conversations', :params => {conversation: conversation}, :headers => headers
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json["messages"]).to eq("Messages in this conversation")
    expect(json["is_success"]).to eq(true)
    expect(json["data"].keys).to contain_exactly('messages')

    get '/api/v1/conversations/1/', :headers => headers
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json["messages"]).to eq("Messages in this conversation")
    expect(json["is_success"]).to eq(true)
    expect(json["data"].keys).to contain_exactly('messages')
  end
end
