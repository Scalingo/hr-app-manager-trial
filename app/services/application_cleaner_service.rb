# frozen_string_literal: true

class ApplicationCleanerService
  attr_reader :application_queue

  def initialize(application_queue)
    @application_queue = application_queue
  end

  def call
    clean_applications
  end

  protected

  def clean_applications
    threads = []

    while application_queue.size.positive?
      application = application_queue.pop

      threads << Thread.new do
        ApplicationDestroyerForRealService.new(application).call
      end
    end

    threads.each(&:join)
  end
end
