class Upvote < ApplicationRecord
  belongs_to :user
  belongs_to :startup
  validates :user_id, uniqueness: { scope: :startup_id, message: "You can only upvote once" }
end
