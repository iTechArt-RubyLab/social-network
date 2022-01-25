# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  net_state  :datetime         not null
#  status     :integer          default('active'), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer          not null
#
# Indexes
#
#  index_users_on_profile_id  (profile_id) UNIQUE
#
class User < ApplicationRecord
  belongs_to :profile
  has_many :messages
  has_many :posts
  has_many :likes
  validates :status, presence: true, inclusion: { in: %w[active blocked] }
  validates :net_state, presence: true
  validates :profile_id, presence: true, uniqueness: true

  enum status: { active: 0, blocked: 1 }

  has_many :user_subscriptions, class_name: 'UserSubscription', foreign_key: 'subscriber_id'
  has_many :subscriptions, through: :user_subscriptions

  has_many :user_subscribers, class_name: 'UserSubscription', foreign_key: 'subscription_id'
  has_many :subscribers, through: :user_subscribers
end
