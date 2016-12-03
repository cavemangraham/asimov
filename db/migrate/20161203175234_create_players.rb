class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :sender_id
      t.string :first_name
      t.string :last_name
      t.string :current_story_node
      t.boolean :bot_alive
      t.boolean :bot_evil

      t.timestamps
    end
  end
end
