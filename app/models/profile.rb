class Profile < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :user_interests

  validates :surname, presence: true, length: {minimum: 255 }
  validates :name, presence: true, length: {minimum: 255 }
  validates :patronymic, length: {minimum: 255 }
  validates :birthday, presence: true
  validates :email, presence: true, length: {minimum: 255 }
  validates :phone, presence: true, uniqueness: true, length: {minimum: 20 }
  validates :photo, presence: true
  validates :about, presence: true
end
