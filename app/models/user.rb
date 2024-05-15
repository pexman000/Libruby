class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true, confirmation: true, length: { minimum: 6 }
    has_one :buyer
    has_one :seller
    has_one :cart
    has_many :borrows
  end
  