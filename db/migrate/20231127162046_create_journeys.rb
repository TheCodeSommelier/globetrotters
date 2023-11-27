class CreateJourneys < ActiveRecord::Migration[7.1]
  def change
    create_table :journeys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :category
      t.date :start_date
      t.date :end_date
      t.string :language
      t.string :currency
      t.time :time_zone
      t.text :packing_list
      t.text :notes

      t.timestamps
    end
  end
end
