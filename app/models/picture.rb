# frozen_string_literal: true

# == Schema Information
#
# Table name: pictures
#
#  id              :bigint           not null, primary key
#  picturable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  picturable_id   :bigint
#
# Indexes
#
#  index_pictures_on_picturable  (picturable_type,picturable_id)
#
class Picture < ApplicationRecord
  belongs_to :picturable, polymorphic: true
  has_many_attached :images
end
