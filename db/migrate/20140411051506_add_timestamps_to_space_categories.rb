class AddTimestampsToSpaceCategories < ActiveRecord::Migration
  def change
    add_timestamps :space_categories
  end
end
