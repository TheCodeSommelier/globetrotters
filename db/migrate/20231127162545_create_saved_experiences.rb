class CreateSavedExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_experiences do |t|
      t.references :experience, null: false, foreign_key: true
      t.references :journey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
