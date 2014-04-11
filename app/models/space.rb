class Space < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_many :space_categories
  has_many :categories, through: :space_categories

  validates :name, presence: true, uniqueness: true
  validates :street_address, presence: true, uniqueness: true 
  validates :city, presence: true
  validates :country, presence: true
  validates :phone, presence: true
  validates :description, presence: true
end