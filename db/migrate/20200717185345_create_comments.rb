class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :post, foreign_key: true, index: true
      t.text :body

      t.timestamps
    end
  end
end
