class RemoveContactsUserIdIndex < ActiveRecord::Migration
  def change
    remove_index :contacts, :user_id
  end
end
