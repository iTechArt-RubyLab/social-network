# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  about      :text
#  birthday   :date             not null
#  hidden     :boolean          default(FALSE), not null
#  name       :string           not null
#  patronymic :string
#  phone      :string(15)
#  surname    :string           not null
#  verified   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_phone    (phone) UNIQUE
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
# Сlass responsible for serializing profile data
class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :surname, :name, :patronymic,
             :birthday, :phone, :about
end
