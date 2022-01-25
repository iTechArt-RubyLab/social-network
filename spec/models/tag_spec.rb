# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { Tag.new(name: "Example tag name") }

  before { subject.save }

  it "name should be present" do
    expect(subject).to be_valid
  end
end
