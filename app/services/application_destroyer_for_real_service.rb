# frozen_string_literal: true

class ApplicationDestroyerForRealService < ApplicationDestroyerService
  def destroy_application
    raise ArgumentError if application.deleted_at.blank?

    application.destroy!
  end
end
