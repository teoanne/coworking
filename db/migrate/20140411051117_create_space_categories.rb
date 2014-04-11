class CreateSpaceCategories < ActiveRecord::Migration
  def change
    create_table :space_categories do |t|
      t.integer :space_id
      t.integer :category_id
    end
  end
end
