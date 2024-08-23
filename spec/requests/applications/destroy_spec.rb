# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application destroy', type: :request do
  it 'soft-deletes the application' do
    application = Application.create!(name: 'sample-app')

    delete "/applications/#{application.id}.json"
    application.reload

    expect(response).to have_http_status(:ok)
    expect(application.deleted_at).not_to be_nil
  end
end
