class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts, force: :cascade do |t|
      t.string :title
      t.string :picture
      t.string :postbody
      t.integer :user_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
