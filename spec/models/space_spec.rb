require 'rails_helper'

describe Spaces do
  describe "#display_most_recent" do
    it 'displays the most recent 10 spaces submitted by users'
    it 'displays less than 10 spaces if there are less than 10 new spaces'
    it 'displays only 10 spaces if there are more than 10 new spaces'
  end

  describe "#total_votes" do
    it 'displays the total votes for the space'
  end
end