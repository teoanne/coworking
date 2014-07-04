class Space < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_many :space_categories
  has_many :categories, through: :space_categories

  has_many :votes, as: :voteable

  validates :name, presence: true, uniqueness: true
  validates :street_address, presence: true, uniqueness: true 
  validates :city, presence: true
  validates :country, presence: true
  validates :phone, presence: true
  #validates_format_of :phone, with: { ^[0-9]*$ } to redo this regex
  validates :description, presence: true

  #self.per_page = 10

  #def category_name #virtual attribute to catch creating categories on the fly. Getter method
    #categories.name if categories
  #end

  #def category_name=(name) #Setter method
    #self.categories = Category.find__or_create_by_name(name) unless name.blank?
  #end

  def list_region
    if self.categories.any?
      self.categories.first.name
    else
      "Not Specified"
    end
  end

  def actual_votes!
    self.actual_votes = self.total_votes
    self.save
  end

  def display_most_recent
    self.first(10)
  end

  def total_votes
    self.upvote - self.downvote
  end

  def downvote
    self.votes.where(vote: false).size
  end

  def upvote
    self.votes.where(vote: true).size
  end
end