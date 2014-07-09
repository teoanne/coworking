class Category < ActiveRecord::Base
  has_many :space_categories
  has_many :spaces, -> { order("created_at DESC") }, through: :space_categories

  validates :name, presence: true

  before_save :generate_slug

  def exists?
    @category.name
  end

  def generate_slug
    self.slug = self.name.downcase
  end

  def to_param
    self.slug
  end
  
end