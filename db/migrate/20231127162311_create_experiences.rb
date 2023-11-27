class CreateExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :experiences do |t|
      t.string :title
      t.text :content
      t.string :address
      t.integer :likes
      t.string :category
      t.references :journey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
