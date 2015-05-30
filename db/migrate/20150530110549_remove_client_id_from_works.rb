class RemoveClientIdFromWorks < ActiveRecord::Migration
  def change
  	remove_columns :works, :client_id
  end
end
