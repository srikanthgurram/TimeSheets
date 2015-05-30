class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.text :details, null: false
      t.decimal :hours
      t.datetime :date_time
      t.timestamps null: false
    end
  end
end
