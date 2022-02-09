# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  about      :text
#  birthday   :date             not null
#  hidden     :boolean          default(FALSE), not null
#  name       :string           not null
#  patronymic :string
#  phone      :string(15)
#  surname    :string           not null
#  verified   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_phone    (phone) UNIQUE
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  include SearchFlip::Model
  has_one :picture, as: :picturable
  belongs_to :user
  has_many :user_interests
  has_many :tags, through: :user_interests

  validates :surname, presence: true
  validates :name, presence: true
  validates :birthday, presence: true
  validates :phone, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :about, presence: true

  default_scope { where(hidden: false) }

  def public?
    !hidden
  end

  def private?
    hidden
  end

  notifies_index(ProfileIndex)
end
