class Work < ActiveRecord::Base
	# Associations
	belongs_to :employee
	belongs_to :project

	#db validations
	validates :details, presence: true
  	validates :employee_id, presence: true
  	validates :project_id, presence: true
end
