class Group < ActiveRecord::Base
	# Fairly straight forward.  Hypes as hypeable may be out of date now Posts are available.
	has_many :events, through: :group_events
	has_many :knockers, -> { select('knockers.*, group_members.admin as is_group_admin') }, through: :group_members # This was an attempt for me to check the current_knocker is a group administrator... Found it somewhere on Stack Overflow, don't think it worked though.
	has_many :venues, through: :group_venues
	has_and_belongs_to_many :interests
	has_many :group_events, dependent: :destroy
	has_many :group_members, dependent: :destroy
	has_many :group_venues, dependent: :destroy
	has_many :groups_interests, dependent: :destroy
	has_many :hypes, as: :author, dependent: :destroy
	has_many :hypes, as: :hypeable, dependent: :destroy
	
	accepts_nested_attributes_for :hypes
	accepts_nested_attributes_for :group_members
	accepts_nested_attributes_for :group_venues
	accepts_nested_attributes_for :groups_interests
	accepts_nested_attributes_for :group_events

	acts_as_messageable

	validates :name,    	presence: true, 
                        	length: { maximum: 50 }
    validates :description, presence: true

	has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100", :micro => "30x30" }, :default_url => "/images/:style/missing2.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

    def feed
    	# An attempt by me to create a news feed on the group page, but it didn't work.
    	Hype.where([hypeable_type == group] && [hypeable_id == group_id])
    end
end
