class AddEmployeeToWoksTable < ActiveRecord::Migration
  def change
  	add_column :works, :employee_id, :integer
  end
end
