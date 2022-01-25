# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  net_state  :datetime         not null
#  status     :integer          default("active"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :integer          not null
#
# Indexes
#
#  index_users_on_profile_id  (profile_id) UNIQUE
#
FactoryBot.define do
  factory :user do
    status { 'active' }
    net_state { Time.now }
    profile_id { rand(1000) }
  end

  factory :blocked_user do
    status { 'blocked' }
    net_state { Time.now }
    profile_id { rand(1000) }
  end
end
