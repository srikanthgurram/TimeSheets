class AddEmployeeClientToWoksTable < ActiveRecord::Migration
  def change
  	add_column :works, :employee_id, :integer
  	add_column :works, :project_id, :integer
  end
end
