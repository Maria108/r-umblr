class CreateTagsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tags, force: :cascade do |t|
      t.string :name
    end
  end
end
