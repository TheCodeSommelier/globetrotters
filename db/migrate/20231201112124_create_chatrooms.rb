class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.references :user_1, foreign_key: { to_table: :users }
      t.references :user_2, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
