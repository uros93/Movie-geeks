class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_voter
  acts_as_follower
  acts_as_followable
  
  has_many :posts
  has_many :comments
  has_many :watched_movies
  has_many :movies , through: :watched_movies
  
  mount_uploader :avatar, AvatarUploader

end
