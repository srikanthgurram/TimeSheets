class Employee < ActiveRecord::Base
	# Associations
	belongs_to :company
	has_many :works
	has_many :projects, :through => :works

	#db validations
	validates :name, presence: true
  validates :company_id, presence: true
end
