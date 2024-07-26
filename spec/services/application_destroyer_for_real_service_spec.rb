require 'rails_helper'

RSpec.describe ApplicationDestroyerForRealService, type: :service do
  context '#call' do
    subject(:destroy_application_for_real) { described_class.new(application).call }

    let(:application) { Application.create!(name: 'sample-app') }

    context 'when application has been soft deleted' do
      before do
        ApplicationDestroyerService.new(application).call
      end

      it 'destroys the application for real' do
        destroy_application_for_real
        expect(Application.find_by(id: application.id)).to be_nil
      end
    end

    context 'when application is not soft deleted' do
      it 'raises an ArgumentError' do
        expect { destroy_application_for_real }.to raise_error(ArgumentError)
      end
    end
  end
end
