class CreateDogsOwnersJoinTable < ActiveRecord::Migration[6.0]
  def change
    #create join table for many to many relationship
    #and index for faster querying
    create_join_table :dogs, :owners do |t|
      t.index :dog_id
      t.index :owner_id

    end
  end
end
