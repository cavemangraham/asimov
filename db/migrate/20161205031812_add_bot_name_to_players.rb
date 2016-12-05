class AddBotNameToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :bot_name, :string
  end
end
