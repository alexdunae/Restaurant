class Waiter < ActiveRecord::Base
	has_many :tables

	has_secure_password

  # This probably doesn't need to be here, right? It was stopping the seeds from running.
  #
  #
	# has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/
end
