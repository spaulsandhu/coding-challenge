class AddUserColumnToPosts < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :user_id, :bigint, index: true
  end

  def down
    remove_column :posts, :user_id
  end
end
