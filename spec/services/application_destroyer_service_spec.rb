# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationDestroyerService, type: :service do
  context '#call' do
    subject(:destroy_application) { described_class.new(application).call }

    let(:application) { Application.create!(name: 'sample-app') }

    it 'soft-deletes the application' do
      destroy_application
      application.reload

      expect(application.deleted_at).not_to be_nil
    end

    it 'appends the deleted_at timestamp to the application name' do
      destroy_application
      application.reload

      expect(application.name).to include("(deleted at #{application.deleted_at})")
    end
  end
end
