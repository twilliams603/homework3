require 'active_record'

class PhoneNumber < ActiveRecord::Base

	validates :category, presence: true
	validates :digits, presence: true

	belongs_to :entry

end
