class DropColorAndAddPhotoUrlFromDogs < ActiveRecord::Migration[6.0]
  def change
    remove_column :dogs, :color 
    add_column :dogs, :photo_url, :string
  end
end
