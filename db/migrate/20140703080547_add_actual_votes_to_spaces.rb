class AddActualVotesToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :actual_votes, :integer, :default => 0
  end
end
