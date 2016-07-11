class WatchedMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  
  acts_as_votable
  acts_as_commentable
  
  include PublicActivity::Model
  tracked only: [:create], owner: Proc.new{ |controller, model| model.user }
end
