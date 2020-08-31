class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :images, default: "https://via.placeholder.com/150"
      t.integer :love
      t.integer :share
      t.timestamps
    end
  end
end
