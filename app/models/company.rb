class Company < ActiveRecord::Base
	# Associations
	has_many :clients
	has_many :employees

	#db validations
	validates :name, presence: true, uniqueness: true  	
end
