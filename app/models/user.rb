class User < ActiveRecord::Base
  has_many :spaces
  has_many :comments

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates_presence_of :country, :full_name

  has_secure_password validations: false #no password confirmation
  
end