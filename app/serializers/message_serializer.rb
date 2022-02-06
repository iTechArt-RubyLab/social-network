# frozen_string_literal: true

# class responsible for serializing message data
class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :updated_at,
             :conversation_id, :user_id
end
