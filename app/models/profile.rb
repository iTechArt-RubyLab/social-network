# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  about      :text
#  birthday   :date             not null
#  email      :string           not null
#  hidden     :boolean          default(FALSE), not null
#  name       :string           not null
#  patronymic :string
#  phone      :string(15)
#  surname    :string           not null
#  verified   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_profiles_on_email  (email) UNIQUE
#  index_profiles_on_phone  (phone) UNIQUE
#
class Profile < ApplicationRecord
  # has_one_attached :photo
  # belongs_to :user
  # has_many :user_interests

  validates :surname, presence: true
  validates :name, presence: true
  validates :birthday, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :about, presence: true
end
