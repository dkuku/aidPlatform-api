describe 'GET /api/v1/tasks' do
  let!(:user) {create(:user)}
  let!(:tasks) { create_list(:random_task, 10) }

  before { get '/api/v1/tasks' }

  it 'returns HTTP status 200' do
    expect(response).to have_http_status 200
  end

  it 'returns all tasks' do
    expect(json[:data][:tasks].size).to eq(10)
  end
end
