# == Schema Information
#
# Table name: applications
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :string
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Application < ApplicationRecord
end
