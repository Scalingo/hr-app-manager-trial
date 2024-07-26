require 'rails_helper'

RSpec.describe 'Application index', type: :request do
  it 'returns living applications only' do
    Application.create(name: 'sample-app')
    Application.create(name: 'web-app')
    Application.create(name: 'deleted-app', deleted_at: Time.now)

    get '/applications.json'

    expect(response.body).to include('sample-app')
    expect(response.body).to include('web-app')
    expect(response.body).not_to include('deleted-app')
  end
end
