class AddMainPhotoAndAdditionalPhotosToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :main_photo, :string
    add_column :spaces, :additional_photos, :string
  end
end
