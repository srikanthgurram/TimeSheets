class AddProjectsToWorksTb < ActiveRecord::Migration
  def change
  	add_column :works, :project_id, :integer
  end
end
