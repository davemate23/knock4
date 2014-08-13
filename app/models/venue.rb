class Venue < ActiveRecord::Base
  # Columns in table should be self explanatory.

	before_save { self.identity = identity.downcase }

	has_many :knockers, -> { select('knockers.*, knocker_venues.admin as is_venue_admin') }, through: :knocker_venues
	has_many :interests, through: :venue_interests
	has_many :events, through: :event_venues
  has_many :groups, through: :group_venues
  has_many :knocker_venues, dependent: :destroy
  has_many :venue_interests, dependent: :destroy
  has_many :event_venues, dependent: :destroy
  has_many :group_venues, dependent: :destroy
  has_many :hypes, as: :author, dependent: :destroy
  has_many :hypes, as: :hypeable, dependent: :destroy
  
  accepts_nested_attributes_for :hypes
  accepts_nested_attributes_for :venue_interests, :allow_destroy => true
  accepts_nested_attributes_for :group_venues
  accepts_nested_attributes_for :knocker_venues
  accepts_nested_attributes_for :event_venues
  
  acts_as_messageable


	has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100", :micro => "30x30" }, :default_url => "/images/:style/missing2.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  VALID_IDENTITY_REGEX = /\A[\w+\-._]+\z/i
  validates :name,          presence: true, 
                            length: { maximum: 50 }
  validates :identity,      presence: true, 
                            length: { maximum: 20 },
                            format: { with: VALID_IDENTITY_REGEX },
                            uniqueness: { case_sensitive: false }
  validates :town,		      presence: true
  validates :postcode,	    presence: true
  validates_format_of :postcode, :with =>  /\A([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\s?[0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))\z/i, :message => "invalid postcode"
  validates :description, presence: true

  geocoded_by :address
	after_validation :geocode

	def address
		[address1, address2, town, county, postcode, country].compact.join(', ')
	end

  # Calculates distance between knocker and venue entity.
  def distance
    self.distance_to(current_knocker)
  end

end
