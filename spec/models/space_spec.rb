require 'rails_helper'

describe Spaces do
  describe "#display_most_recent" do
    it 'displays the most recent 10 spaces submitted by users' do
      space1 = Fabricate(:space, created_at: 1.day.ago)
      space2 = Fabricate(:space, created_at: 2.days.ago)
      space3 = Fabricate(:space, created_at: 1.week.ago)
      expect(self.display_most_recent).to match_array([space1, space2, space3])
    end

    it 'displays less than 10 spaces if there are less than 10 new spaces' 
    it 'displays only 10 spaces if there are more than 10 new spaces'
  end

  describe "#total_votes" do
    it 'displays the total votes for the space'
  end
end