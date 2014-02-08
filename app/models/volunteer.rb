require 'digest/sha1'

class Volunteer < ActiveRecord::Base
  belongs_to :area
  has_many :shifts, :order => 'start ASC'
  has_many :schedules, :through=>:shifts
 has_many :signups
  has_many :comments, :order => 'created_at DESC'
  validates_presence_of :name
  validates_uniqueness_of :name
  belongs_to :picture
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  def self.authenticate(name,password)
     volunteer = self.find_by_name(name)||self.find_by_name(name.titlecase)||self.find_by_name(name.upcase)||self.find_by_name(name.downcase)||self.find_by_name(name.downcase.titlecase)
       if volunteer
         expected_pw = enc_pw(password, volunteer.salt)
       if volunteer.hashed_pw != expected_pw
         volunteer=nil
       end
     end
     volunteer
  end

  def availability
    @availability
  end
  def sign_up
	  @sign_up
  end
  # 0-no, 1-yes
  def sign_up=(su)
	  thisyear=Date.today.year
	  @sign_up=su
	  return if @sign_up=='0'
	  s= self.signups.last
	  if s.nil? || s.year!=thisyear then
	  s=Signup.new(:volunteer_id=>self.id, :year=>thisyear)
	 end
	  s.tix_ad=self.tickets
	   s.tix_st=self.tix_students
	    s.tix_ch=self.tix_kids
	  s.save
	  add_signup(s)
  end
  def tix
	  @tix
  end
  def tix_st
	  @tix_st
  end
  def tix_ch
	  @tix_ch
  end
  
  def tix=(t)
	  self.tickets=t
	  s=self.signups.last
	  return if !s
	  s.tix_ad=t
	  s.save
	  
  end
  def tix_st=(t)
	  self.tix_students=t
	  s=self.signups.last
	  return if !s
	  s.tix_st=t
	  s.save
  end
  def tix_ch=(t)
	  self.tix_kids=t
	  s=self.signups.last
	  return if !s
	  s.tix_ch=t
	  s.save
  end
  def availability=(av)
    @availability=av
    return if av.blank?
  end

  def password
    @password
  end

 
  def password=(pw)
    @password=pw
    return if pw.blank?
    create_new_salt
    self.hashed_pw=Volunteer.enc_pw(self.password, self.salt)
  end

 def after_destroy
    if Volunteer.count.zero?
      raise "Can't delete last volunteer"
    end
  end
  def add_shift(shift)
    shifts << shift
    save
  end
   def remove_shift(shift)
    shifts.delete(shift)
    save
  end
  def add_signup(su)
	  signups << su
	  save
  end
  
private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_pw.blank?
  end

  def self.enc_pw(pw, salt)
    string_to_hash = pw + "mystery" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt= self.object_id.to_s + rand.to_s
  end

end

