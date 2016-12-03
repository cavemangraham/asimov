class AddDefaultValuesToBotBooleans < ActiveRecord::Migration[5.0]
  def up
    change_column :players, :bot_alive, :boolean, :default => true
    change_column :players, :bot_evil, :boolean, :default => false
  end

  def down
    change_column :players, :bot_alive, :boolean, :default => nil
    change_column :players, :bot_evil, :boolean, :default => nil
  end
end
