# frozen_string_literal: true

# Сlass responsible for serializing profile data
class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :surname, :name, :patronymic,
             :birthday, :phone, :about
end
