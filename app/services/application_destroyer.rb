class ApplicationDestroyer
  attr_reader :application

  def initialize(application)
    @application = application
  end

  def call
    destroy_application
  end

  protected

  def destroy_application
    application.deleted_at = Time.now
    application.name = "#{application.name} (deleted at #{application.deleted_at})"
    application.save!
  end
end
