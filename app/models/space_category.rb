class SpaceCategory < ActiveRecord::Base  
  belongs_to :space 
  belongs_to :category
end