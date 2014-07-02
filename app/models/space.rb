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
  validates :description, presence: true

  #self.per_page = 10

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