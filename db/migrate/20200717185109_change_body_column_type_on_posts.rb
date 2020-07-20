class ChangeBodyColumnTypeOnPosts < ActiveRecord::Migration[5.1]
  def up
    change_column :posts, :body, :text
  end

  def down
    change_column :posts, :body, :string
  end
end
