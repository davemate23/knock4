class Knocker < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

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

    geocoded_by :address
    after_validation :geocode

    self.per_page = 20

    def address
      [town, postcode, country].compact.join(', ')
    end

    def feed
      Hype.from_knockers_favourited_by(self)
    end

    def self.all_except(knocker)
      where.not(id: knocker)
    end

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

 	def name
 		first_name + " " + last_name
 	end

  def mailboxer_email(object)
    return email
  end

  def favourited?(other_knocker)
    favouriteknockers.find_by(favourite_id: other_knocker.id)
  end

  def favourite!(other_knocker)
    favouriteknockers.create!(favourite_id: other_knocker.id)
  end

  def unfavourite!(other_knocker)
    favouriteknockers.find_by(favourite_id: other_knocker.id).destroy
  end

  has_many :hypes, as: :author, dependent: :destroy
  has_many :posts, as: :postable, dependent: :destroy
  accepts_nested_attributes_for :hypes
  has_many :favourite_knockers, through: :favouriteknockers, source: :favourite
  has_many :favouriteknockers, foreign_key: "favourited_id", dependent: :destroy
  has_many :reverse_favouriteknockers, foreign_key: "favourite_id",
                                        class_name: "Favouriteknocker",
                                        dependent: :destroy
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
  acts_as_messageable

end
