require 'rails_helper'

describe Space do
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

  describe "search_by_name" do

    let(:space1) { Fabricate(:space, name: "Space 1", created_at: 2.days.ago) }
    let(:space2) { Fabricate(:space, name: "Space 2", created_at: 1.week.ago) }

    it 'returns an empty array if there is no match' do
      expect(Space.search_by_name("hoo")).to eq([])
    end

    it 'returns an array of one exact match if there is an exact match' do
      expect(Space.search_by_name("Space 1")).to eq([space1])
    end

    it 'returns the relevant matches if there is a partial match' do
      expect(Space.search_by_name("1")).to eq([space1])
    end

    it 'returns an array of matches ordered by created_at' do
      expect(Space.search_by_name("Space")).to eq([space1, space2])
    end

    it 'displays an error message if no parameters were passed into the search box' do
      expect(Space.search_by_name("")).to eq("Your search term was empty.")
    end
  end
end