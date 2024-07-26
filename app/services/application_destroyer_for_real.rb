class ApplicationDestroyerForReal < ApplicationDestroyer
  def destroy_application
    raise ArgumentError unless application.deleted_at.present?

    application.destroy!
  end
end
