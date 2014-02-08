class Area < ActiveRecord::Base
	has_many :locations
	has_many :volunteers
	has_many :schedules
end
