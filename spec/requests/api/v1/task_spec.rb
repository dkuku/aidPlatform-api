require 'rails_helper'
describe Task do

  context "create" do
    it "returns all required parameters" do
      create(:user)
      task = create(:task).to_json
      expect(task).to have_json_path("id")
      expect(task).to have_json_type(Integer).at_path("id")
      expect(task).to have_json_path("title")
      expect(task).to have_json_type(String).at_path("title")
      expect(task).to have_json_path("description")
      expect(task).to have_json_type(String).at_path("description")
      expect(task).to have_json_path("lat")
      expect(task).to have_json_type(Float).at_path("lat")
      expect(task).to have_json_path("lng")
      expect(task).to have_json_type(Float).at_path("lng")
      expect(task).to have_json_path("task_type")
      expect(task).to have_json_type(String).at_path("task_type")
    end
  end
end

describe 'Remote api request to task' do
  it 'should not allow to create task when unauthenticated' do

    task = attributes_for(:task)
    post '/api/v1/tasks', :params => {task: task}
    expect(response).to have_http_status(401)
    json = JSON.parse(response.body)
    expect(json["messages"]).to eq("Unauthenticated")
    expect(json["is_success"]).to eq(false)
  end

  it 'should create task when proper header is send' do 
    user = create(:user).to_json
    task = attributes_for(:task)
    token = JSON.parse(user)["authentication_token"]
    headers = {'AUTH-TOKEN': token}
    post '/api/v1/tasks', :params => {task: task}, :headers => headers
    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    expect(json).not_to be_empty
    expect(json["messages"]).to eq("Created task successfully")
    expect(json["is_success"]).to eq(true)
    expect(json["data"].keys).to contain_exactly('task')
    expect(json["data"]["task"].keys).to contain_exactly('id',
      'created_at', 'updated_at', 'title', 'description', 'lat', 'lng',
     'fulfilment_counter', 'done', 'task_type', 'user_id')
    expect(json["data"]["task"]["title"]).to eq("title")
    expect(json["data"]["task"]["description"]).to eq("body")
    expect(json["data"]["task"]["done"]).to eq(0)
    expect(json["data"]["task"]["task_type"]).to eq("material")
  end
end

describe 'GET /api/v1/tasks' do
  let!(:user) {create(:user)}
  let!(:tasks) { create_list(:random_task, 10) }

  before { get '/api/v1/tasks' }

  it 'returns HTTP status 200' do
    expect(response).to have_http_status 200
  end
end