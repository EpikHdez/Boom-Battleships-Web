class User < ApplicationRecord
    has_secure_password

    validates_presence_of :name, on: :create, message: "can't be blank"
    validates_presence_of :password_digest, on: :create, message: "can't be blank"
    validates_presence_of :email, on: :create, message: "can't be blank"

    validates_uniqueness_of :email, on: :create, message: "must be unique"

    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships, source: :friend

    has_many :matches, dependent: :destroy
    has_many :rivals, through: :matches, source: :rival

    has_many :inventories, dependent: :destroy
    has_many :items, through: :inventories, source: :item

    belongs_to :user_type
end
