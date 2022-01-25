class UserInterest < ApplicationRecord
    belongs_to :profile
    belongs_to :tag

    validates :profile_id, uniqueness: { scope: :tag_id }
end
