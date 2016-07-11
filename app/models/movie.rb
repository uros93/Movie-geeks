class Movie < ActiveRecord::Base
    has_many :watched_movies
    has_many :users , through: :watched_movies
end
