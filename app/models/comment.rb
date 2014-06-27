class Comment < ActiveRecord::Base
  belongs_to :space
  belongs_to :user

  has_many :votes, as: :voteable

  validates :body, presence: true

  # add that latest comment to be displayed first

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