require 'active_record'

class EmailAddress < ActiveRecord::Base

	validates :category, presence: true
	validates :address, presence: true

	belongs_to :entry

end
