# frozen_string_literal: true

class ApplicationDestroyerService
  attr_reader :application

  def initialize(application)
    @application = application
  end

  def call
    destroy_application
  end

  protected

  def destroy_application
    application.deleted_at = Time.zone.now
    application.name = "#{application.name} (deleted at #{application.deleted_at})"
    application.save!
  end
end
