# frozen_string_literal: true

# Elasticsearch
class ConversationIndex
  include SearchFlip::Index

  def self.index_name
    'conversations'
  end

  def self.model
    Conversation
  end

  def self.serialize(conversation)
    {
      name: conversation.name
    }
  end
end
