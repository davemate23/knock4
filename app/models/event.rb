class Event < ActiveRecord::Base
	has_many :venues, through: :event_venues
	has_many :interests, through: :event_interests
	has_many :event_interests, dependent: :destroy
	has_many :knockers, through: :event_attendances
	has_many :groups, through: :group_events
	has_many :event_venues, dependent: :destroy
	has_many :event_attendances, dependent: :destroy
	has_many :group_events, dependent: :destroy
	has_many :hypes, as: :author, dependent: :destroy
	has_many :hypes, as: :hypeable, dependent: :destroy
	accepts_nested_attributes_for :hypes
	acts_as_messageable

	validates :name,    	presence: true, 
                        	length: { maximum: 50 }
    validates :start_time, 	presence: true
    validates :description, presence: true

    has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100", :micro => "30x30" }, :default_url => "/images/:style/missing2.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
