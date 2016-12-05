class AddBotGenderToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :bot_gender, :string
  end
end
