class Comment < ActiveRecord::Base
	 validates_presence_of :volunteer_id

	belongs_to :volunteer
end
