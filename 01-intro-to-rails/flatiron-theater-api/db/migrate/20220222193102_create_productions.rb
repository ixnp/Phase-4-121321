class CreateProductions < ActiveRecord::Migration[7.0]
  def change
    create_table :productions do |t|
      t.string :title
      t.string :genre
      t.text :description
      t.float :budget
      t.string :image
      t.string :director
      t.boolean :ongoing

      t.timestamps
    end
  end
end
