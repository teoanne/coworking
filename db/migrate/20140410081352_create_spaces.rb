class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :country
      t.string :phone
      t.string :description
      t.timestamps
    end
  end
end
