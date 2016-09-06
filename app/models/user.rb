class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :omniauth_providers => [:facebook]
          
  acts_as_voter
  acts_as_follower
  acts_as_followable
  

  
  has_many :posts
  has_many :comments
  has_many :watched_movies
  has_many :movies , through: :watched_movies
  
  mount_uploader :avatar, AvatarUploader
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.skip_confirmation!
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.remote_avatar_url = auth.info.image.gsub('http://','https://') # assuming the user model has an image
      user.oauth_token = auth.credentials.token
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    
  end

end
