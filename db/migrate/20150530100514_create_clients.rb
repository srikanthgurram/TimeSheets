class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.integer :company_id, null: false
      t.timestamps null: false
    end
  end
end
