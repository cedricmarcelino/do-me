class ChangeIsDoneDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :is_done, false
  end
end
