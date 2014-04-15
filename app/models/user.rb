class User < ActiveRecord::Base
  has_many :spaces
  has_many :comments

  validates :username, presence: true, uniqueness: true
  
end