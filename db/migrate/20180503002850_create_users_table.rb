class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users, force: :cascade do |t|
      t.string :first_name
      t.string :last_name
      t.string :d_o_b
      t.string :email
      t.string :password
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
