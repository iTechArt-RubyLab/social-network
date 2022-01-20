class Profile < ApplicationRecord
  #has_one_attached :photo
  #belongs_to :user
  #has_many :user_interests

  validates :surname, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :patronymic, length: { maximum: 255 }
  validates :birthday, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :phone, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :about, presence: true
end
