# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  has_many :user_interests
  has_many :profiles, through: :user_interests

  validates_uniqueness_of :name, case_sensitive: false
end
