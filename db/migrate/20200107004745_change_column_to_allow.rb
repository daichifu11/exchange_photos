class ChangeColumnToAllow < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :account_name, :string, null: true
    change_column :users, :nick_name, :string, null: true
  end

  def down
    change_column :users, :account_name, :string, null: false
    change_column :users, :nick_name, :string, null: false
  end
end
