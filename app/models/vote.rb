class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user #this is the foreign key

  validates_uniqueness_of :user, scope: :voteable
end