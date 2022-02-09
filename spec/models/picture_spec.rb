# frozen_string_literal: true

# == Schema Information
#
# Table name: pictures
#
#  id              :bigint           not null, primary key
#  picturable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  picturable_id   :bigint
#
# Indexes
#
#  index_pictures_on_picturable  (picturable_type,picturable_id)
#
require 'rails_helper'

RSpec.describe Picture, type: :model do
  context 'with post associations' do
    let(:posts) { FactoryBot.create :picture, :posts }

    it { is_expected.to belong_to(:picturable) }
  end

  context 'with profile associations' do
    let(:profiles) { FactoryBot.create :picture, :profiles }

    it { is_expected.to belong_to(:picturable) }
  end

  context 'with empty image attributes' do
    let(:empty) { FactoryBot.build :picture, :empty }

    it { expect(empty).not_to be_valid }
  end
end
