class Picture < ApplicationRecord
  belongs_to :picturable, polymorphic: true
  has_one_attached :picture
end
