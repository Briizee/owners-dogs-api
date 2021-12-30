class CreateDogs < ActiveRecord::Migration[6.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.string :color
      t.string :sex

      t.timestamps
    end
  end
end
