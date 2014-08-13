class Knocker < ActiveRecord::Base
  # Wow, this one might be a big one!..

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

    before_create :build_profile #creates profile at user registration
    before_save { self.identity = identity.downcase }

    validates :first_name,    presence: true, 
                              length: { maximum: 25 }
    validates :last_name,     presence: true, 
                              length: { maximum: 25 }
    VALID_IDENTITY_REGEX = /\A[\w+\-._]+\z/i
    validates :identity,      presence: true, 
                              length: { maximum: 20 },
                              format: { with: VALID_IDENTITY_REGEX },
                              uniqueness: { case_sensitive: false }
    validates :email, 			  presence: true
    validates :password,      presence: true
    validates :birthday,      presence: true
    validates :gender, 			  presence: true
    validates :postcode, 		  presence: true
    validates_format_of :postcode, :with =>  /\A([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\s?[0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))\z/i, :message => "invalid postcode"

    has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100", :micro => "30x30", :large => "500x500>" }, :default_url => "/images/:style/missing.jpg"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

    # This works with the Geocoder Gem to get locations from user postcodes.
    geocoded_by :address
    after_validation :geocode

    # Works with Kaminari Gem.
    paginates_per 20

    # Collects address attributes together for a more competent search on google... may create complications sometimes though where things don't work as well when combined.
    def address
      [town, postcode, country].compact.join(', ')
    end

    # Attempt to create a feed on knocker profile... see favouriteknocker conttoller for more info.
    def feed
      Hype.from_knockers_favourited_by(self)
    end

    # Think I created this for the Knockers index page to display all Knockers except current_knocker.
    def self.all_except(knocker)
      where.not(id: knocker)
    end

  	
    # The following code is all related to Omni Auth, as with the controller, probably best to leave this for now until the site is more ready for launch.
    def self.find_for_facebook_oauth(auth)
	  	where(auth.slice(:provider, :uid)).first_or_create do |knocker|
	      knocker.provider = auth.provider
	      knocker.uid = auth.uid
	      knocker.email = auth.info.email
	      knocker.password = Devise.friendly_token[0,20]
	      #knocker.first_name = auth.info.name   # assuming the user model has a name
	      #knocker.image = auth.info.image # assuming the user model has an image
	  	end
	end

	def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    	knocker = Knocker.where(:provider => auth.provider, :uid => auth.uid).first
    	if knocker
      		return knocker
    	else
  			registered_knocker = Knocker.where(:email => auth.uid + "@twitter.com").first
  			if registered_knocker
    			return registered_knocker
  			else
    			knocker = Knocker.create(full_name:auth.extra.raw_info.name,
                        provider:auth.provider,
                        uid:auth.uid,
                        email:auth.uid+"@twitter.com",
                        password:Devise.friendly_token[0,20],
                        identity:auth.info.nickname,
                        about:auth.info.description                    )
  		end
   	end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
	    data = access_token.info
	    knocker = Knocker.where(:provider => access_token.provider, :uid => access_token.uid ).first
	    if knocker
	      return knocker
	    else
	      registered_knocker = Knocker.where(:email => access_token.info.email).first
	      if registered_knocker
	        return registered_knocker
	      else
	        knocker = Knocker.create(first_name: data["first_name"],
	          last_name: data["last_name"],
	          provider:access_token.provider,
	          email: data["email"],
	          uid: access_token.uid ,
	          password: Devise.friendly_token[0,20],
	          gender: data["gender"],
	          birthday: data["birthday"]
	        )
	      end
	   	end
	end

	def self.new_with_session(params, session)
    	super.tap do |knocker|
      		if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        		knocker.email = data["email"] if knocker.email.blank?
      		end
    	end
 	end

 	# method to get the full name from first and last attributes

  def name
 		first_name + " " + last_name
 	end

  def mailboxer_email(object)
    return email
  end

  # Checks whether the knocker instance is a favourite of current_knocker to see if there should be an option to Favourite or Unfavourite in view.
  def favourited?(other_knocker)
    favouriteknockers.find_by(favourite_id: other_knocker.id)
  end

  # Allows a knocker to favourite another knocker (not sure if this works).
  def favourite!(other_knocker)
    favouriteknockers.create!(favourite_id: other_knocker.id)
  end

  # Allows a knocker to unfavourite another knocker (not sure if this works).
  def unfavourite!(other_knocker)
    favouriteknockers.find_by(favourite_id: other_knocker.id).destroy
  end

  has_one :profile, dependent: :destroy
  has_many :hypes, as: :author, dependent: :destroy
  has_many :posts, as: :postable, dependent: :destroy
  accepts_nested_attributes_for :hypes
  has_many :favourite_knockers, through: :favouriteknockers, source: :favourite
  has_many :favouriteknockers, foreign_key: "favourited_id", dependent: :destroy # This is probably why I messed this all up!
  has_many :reverse_favouriteknockers, foreign_key: "favourite_id",
                                        class_name: "Favouriteknocker",
                                        dependent: :destroy # Allows for a two way relationship (favourite and favourited)
  has_many :favourited_knockers, through: :reverse_favouriteknockers, source: :favourited
  has_many :interests, through: :knocker_interests
  has_many :venues, through: :knocker_venues
  has_many :events, through: :event_attendances
  has_many :groups, through: :group_members
  has_many :knocker_interests, dependent: :destroy
  has_many :knocker_venues, dependent: :destroy
  has_many :event_attendances, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :knocker_venues
  accepts_nested_attributes_for :knocker_interests
  accepts_nested_attributes_for :event_attendances
  accepts_nested_attributes_for :group_members
  
  acts_as_messageable


end
