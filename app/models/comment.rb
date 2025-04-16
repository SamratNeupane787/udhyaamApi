class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :startup

  validates: context, presence: true
end
