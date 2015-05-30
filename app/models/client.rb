class Client < ActiveRecord::Base
	# Associations
	belongs_to :company
	has_many :projects

	#db validations
	validates :name, presence: true, uniqueness: true
  	validates :company_id, presence: true
end
