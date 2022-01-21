# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  status     :integer          default("public"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'with valid attributes' do
  let(:post) { FactoryBot.create :post}
    it { expect(post).to be_valid }
  end

  context 'with invalid attributes' do
    let(:post) { FactoryBot.build :post, :invalid_body }
    it { expect(post).not_to be_valid }
  end

  context 'with empty attributes' do
    let(:post) { FactoryBot.build :post, :empty }
    it { expect(post).not_to be_valid }
  end
end
