class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
