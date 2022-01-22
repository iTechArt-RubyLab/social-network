class Picture < ApplicationRecord
  belongs_to :picturable, polymorphic: true
  has_many_attached :images
end
