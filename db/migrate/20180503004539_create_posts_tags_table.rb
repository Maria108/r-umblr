class CreatePostsTagsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts_tags, force: :cascade do |t|
      t.string :tag_id
      t.string :post_id
    end
  end
end
