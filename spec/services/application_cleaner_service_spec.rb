require 'rails_helper'

RSpec.describe ApplicationCleanerService, type: :service do
  context '#call' do
    subject(:clean_applications) { described_class.new(application_queue).call }

    let(:application_queue) { Queue.new }
    let(:application) { Application.create!(name: 'sample-app', deleted_at: Time.now) }

    before do
      application_queue << application
    end

    it 'destroys the applications' do
      expect { clean_applications }.to change(Application, :count).by(-application_queue.size)
    end

    it 'uses AplicationDestroyerForReal service' do
      application_destroyer = instance_double(ApplicationDestroyerForRealService)

      allow(ApplicationDestroyerForRealService).to receive(:new).and_return(application_destroyer)
      allow(application_destroyer).to receive(:call)

      clean_applications

      expect(ApplicationDestroyerForRealService).to have_received(:new).with(application).once
      expect(application_destroyer).to have_received(:call).once
    end

    it 'operates using threads' do
      allow(Thread).to receive(:new).and_call_original

      clean_applications

      expect(Thread).to have_received(:new)
    end
  end
end
