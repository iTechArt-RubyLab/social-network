# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id           :bigint           not null, primary key
#  likable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  likable_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_likes_on_likable  (likable_type,likable_id)
#  index_likes_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'with valid associations' do
    let(:like) { FactoryBot.create :like }

    it { should belong_to(:user) }
    it { should belong_to(:likable) }
  end
end
