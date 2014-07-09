class User < ActiveRecord::Base

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates_presence_of :country
  validates :full_name, presence: true, uniqueness: true

  has_secure_password validations: false #no password confirmation

  has_many :spaces
  has_many :comments
  has_many :votes

  before_save :generate_slug

  def deactivate!
    update_column(:active, false)
  end

  def activate!
    update_column(:active, true)
  end

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.username.downcase
  end
  
end