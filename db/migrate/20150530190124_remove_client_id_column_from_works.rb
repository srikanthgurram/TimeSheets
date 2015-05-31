class RemoveClientIdColumnFromWorks < ActiveRecord::Migration
  def change
  	remove_column :works, :client_id
  end
end
