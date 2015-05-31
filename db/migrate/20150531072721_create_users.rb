class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :image
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
      t.timestamps null: false
    end
  end
end
