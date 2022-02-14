class ChangeIsDoneDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :is_done, false
  end
end
