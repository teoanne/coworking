class Category < ActiveRecord::Base
  has_many :space_categories
  has_many :spaces, -> { order("created_at DESC") }, through: :space_categories

  validates :name, presence: true
end