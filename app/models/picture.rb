class Picture < ActiveRecord::Base
	validates_presence_of :comment, :name, :content_type,  :message => "must specify a file"
	#validates_format_of :content_type, :with => /^image/, :message => "... you can only upload pictures"
	
	#validates_length_of :data, :maximum=>100.kilobytes, :message=>"less than %d if you don't mind"
	def self.upload_dir
    # create a directory: public/images/uploads
    Rails.root.join('public', 'images', 'uploads')
  end
	def uploaded_picture=(picture_field)
		return if picture_field.nil?
		self.name=base_part_of(picture_field.original_filename)
		self.content_type=picture_field.content_type.chomp
		#self.data=picture_field.read
		# create a migration to add this column
    		self.path         = File.join(Picture.upload_dir, "#{self.name}")
		#File.join(Picture.upload_dir, "#{self.id}.#{extension(picture_field.original_filename)}")
	
	
	# write the file to the path
	File.open(self.path, "wb") {|f| f.write(picture_field.read)}
	end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end
  
  def extension(file_name)
    File.extname(file_name)
  end
	
end
