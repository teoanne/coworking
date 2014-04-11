class Category < ActiveRecord::Base
  has_many :space_categories
  has_many :spaces, through: :space_categories
end