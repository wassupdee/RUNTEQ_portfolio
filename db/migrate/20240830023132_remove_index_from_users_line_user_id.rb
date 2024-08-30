class RemoveIndexFromUsersLineUserId < ActiveRecord::Migration[7.1]
  def change
    remove_index :users, :line_user_id
  end
end
