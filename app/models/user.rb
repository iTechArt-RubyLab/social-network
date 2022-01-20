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
class User < ApplicationRecord
  validates :status, presence: true, inclusion: { in: %w[active blocked] }
  validates :net_state, presence: true
  validates :profile_id, presence: true, uniqueness: true

  enum status: %i[active blocked]
end
