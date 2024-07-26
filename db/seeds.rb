# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
{
  'sample-app' => 'This is a sample application',
  'web-app' => 'Frontend production application',
  'staging-web-app' => 'Frontend application on staging environment',
  'api' => 'API production backend',
  'staging-api' => 'API backend on staging environment',
  'cities-manager' => 'Application to manage cities'
}.each do |app_name, app_description|
  app = Application.find_or_create_by!(name: app_name)
  app.update_attribute!(:description, app_description)
end
