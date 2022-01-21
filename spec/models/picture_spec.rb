require 'rails_helper'

RSpec.describe Picture, type: :model do
  let(:invalid) { FactoryBot.build :picture, :invalid }
  let(:empty) { FactoryBot.build :picture, :empty }

  context 'with valid attributes' do
    it { expect(invalid).to_not be_valid }
  end
  context 'with empty attributes' do
    it { expect(empty).to_not be_valid }
  end
end
