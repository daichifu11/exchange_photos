class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def up
    change_column_null :users, :nick_name, :string, false
  end

  def down
    change_column_null :users, :nick_name, :string, true
  end
end
