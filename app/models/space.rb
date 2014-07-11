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

  mount_uploader :main_photo, MainPhotoUploader
  mount_uploader :additional_photos, AdditionalPhotosUploader

  before_save :generate_slug
  

  #self.per_page = 10

  #def category_name #virtual attribute to catch creating categories on the fly. Getter method. Refer to Ryan Bates's railscast on this
    #categories.name if categories
  #end

  #def category_name=(name) #Setter method
    #self.categories = Category.find__or_create_by_name(name) unless name.blank?
  #end

  def self.search_by_name(search_term)
    return "Your search term was empty." if search_term.blank?
    where("name LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

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

  def to_param
    self.slug
  end

  def generate_slug
    the_slug = to_slug(self.name)
    space = Space.find_by(slug: the_slug)
    count = 2
    while space && space != self
      the_slug = append_suffix(the_slug, count)
      space = Space.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split("-").last.to_i != 0
      return str.split("-").slice(0...-1).join("-") + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end 
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, "-"
    str.gsub! /-+/, "-"
    str.downcase 
  end
end