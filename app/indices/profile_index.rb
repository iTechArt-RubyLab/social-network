# frozen_string_literal: true

# Elasticsearch
class ProfileIndex
  include SearchFlip::Index

  def self.index_name
    'profiles'
  end

  def self.model
    Profile
  end

  def self.serialize(profile)
    {
      surname: profile.surname,
      name: profile.name,
      patronymic: profile.patronymic,
      birthday: profile.birthday,
      phone: profile.phone,
      about: profile.about
    }
  end
end
