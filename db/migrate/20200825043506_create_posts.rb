class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :images
      t.integer :love
      t.integer :share
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
