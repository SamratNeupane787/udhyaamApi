class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :startups, dependent: :destroy
  has_many :upvotes, dependent: :destroy
  has_many :comments, dependent: :destroy
  def change
  add_column :users, :jti, :string, null: false
  add_index :users, :jti, unique: true
  end
end
