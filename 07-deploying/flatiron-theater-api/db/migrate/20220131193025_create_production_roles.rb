class CreateProductionRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :production_roles do |t|
      t.string :role
      t.boolean :understudy
      t.belongs_to :production, null: false, foreign_key: true

      t.timestamps
    end
  end
end
