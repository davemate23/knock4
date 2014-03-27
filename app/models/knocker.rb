class Knocker < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

    before_save { self.username = username.downcase }

    validates :first_name,    presence: true, 
                              length: { maximum: 25 }
    validates :last_name,     presence: true, 
                              length: { maximum: 25 }
    VALID_USERNAME_REGEX = /\A[\w+\-._]+\z/i
    validates :username,      presence: true, 
                              length: { maximum: 20 },
                              format: { with: VALID_USERNAME_REGEX },
                              uniqueness: { case_sensitive: false }
    validates :email, 			  presence: true
    validates :password, 		  presence: true
    validates :dob, 			    presence: true
    validates :gender, 			  presence: true
    validates :postcode, 		  presence: true

    has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }, :default_url => "/images/:style/missing.jpg"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

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
                        username:auth.info.nickname,
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
	          dob: data["birthday"]
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
end
