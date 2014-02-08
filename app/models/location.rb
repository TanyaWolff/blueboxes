class Location < ActiveRecord::Base
  has_many :shifts, :dependent=>:destroy
  belongs_to :area
  has_and_belongs_to_many :schedules
end
