require 'rails_helper'

RSpec.describe 'Application search', type: :request do
  it 'search for applications name and/or description' do
    Application.create(name: 'sample-app', description: 'Sample application')
    Application.create(name: 'web-app', description: 'Web app used as a sample')
    Application.create(name: 'useless-app', description: 'This app is useless (or not)')

    get '/applications/search.json', params: { q: 'Sample' }

    expect(response.body).to include('sample-app')
    expect(response.body).to include('web-app')
    expect(response.body).not_to include('useless-app')
  end

  it '[bonus] search is aware of English language' do
    Application.create(name: 'cities-manager', description: 'This is a backend API')
    Application.create(name: 'web-app', description: 'The front of cities manager')
    Application.create(name: 'working-api', description: 'This is an API')
    Application.create(name: 'health-checker', description: 'This make sure everything STILL WORKS')

    get '/applications/search.json', params: { q: 'City' }

    expect(response.body).to include('cities-manager')
    expect(response.body).to include('web-app')
    expect(response.body).not_to include('working-api')
    expect(response.body).not_to include('health-checker')

    get '/applications/search.json', params: { q: 'worked' }

    expect(response.body).to include('working-api')
    expect(response.body).to include('health-checker')
    expect(response.body).not_to include('cities-manager')
    expect(response.body).not_to include('web-app')
  end
end
