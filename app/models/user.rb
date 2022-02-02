# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  status                 :integer          default("active"), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_one :profile
  accepts_nested_attributes_for :profile
  has_many :messages
  has_many :posts
  has_many :likes
  has_many :user_subscriptions, class_name: 'UserSubscription', foreign_key: 'subscriber_id'
  has_many :subscriptions, through: :user_subscriptions
  has_many :user_subscribers, class_name: 'UserSubscription', foreign_key: 'subscription_id'
  has_many :subscribers, through: :user_subscribers
  has_many :user_conversations
  has_many :users, through: :user_conversations, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[active blocked] }

  enum status: { active: 0, blocked: 1 }
end
