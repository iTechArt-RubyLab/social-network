require 'rails_helper'

RSpec.describe Picture, type: :model do
  let(:invalid) { FactoryBot.build :picture, :invalid }
  let(:empty) { FactoryBot.build :picture, :empty }

  context 'with valid attributes' do
    it { expect(invalid).not_to be_valid }
  end

  context 'with empty attributes' do
    it { expect(empty).not_to be_valid }
  end
end
