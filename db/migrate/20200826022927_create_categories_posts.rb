class CreateCategoriesPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_posts do |t|
        t.belongs_to :category
        t.belongs_to :post
    end
  end
end
