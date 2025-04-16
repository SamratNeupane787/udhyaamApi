class Startup < ApplicationRecord
  belongs_to :user
  has_many :upvotes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
end
