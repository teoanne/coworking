class User < ActiveRecord::Base
  has_many :spaces
  has_many :comments

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :country, presence: true

  has_secure_password validation: false
  
end