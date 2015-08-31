class Pin < ActiveRecord::Base
	# Devise gem
	belongs_to :user 

	# Paperclip Gem
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end

#I've added user_id first by generating a new migration: 
#rails generate migration add_user_id_to_pins user_id:integer:index
# Then I've set up association so that Pins can belong to user. 
# This means pins will have a user_id parameter as well
# and also a "user has many pins" has_many :pins