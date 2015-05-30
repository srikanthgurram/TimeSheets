class Project < ActiveRecord::Base
	#Associations	
	belongs_to :client
	has_many :employees
	has_many :works

	#add validations
	validates :name, presence: true, uniqueness: true
  	validates :client_id, presence: true
end
