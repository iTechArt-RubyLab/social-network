# frozen_string_literal: true

# Elasticsearch
class TagIndex
  include SearchFlip::Index

  def self.index_name
    'tags'
  end

  def self.model
    Tag
  end

  def self.serialize(tag)
    {
      name: tag.name
    }
  end
end
