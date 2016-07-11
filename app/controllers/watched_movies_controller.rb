class WatchedMoviesController < ApplicationController
    def create
        
        unless Movie.exists?(:imdbid => params[:imdbid])
            movie = Imdb::Movie.new(params[:imdbid])
            add = Movie.new(:title => movie.title, :imdbid => movie.id, :poster => movie.poster)
            
            if add.save
            else
                return
            end
            watched = current_user.watched_movies.build(:movie_id => add.id)
        else
            
            result = Movie.where(:imdbid => params[:imdbid]).first
            if current_user.movies.include?(result)
                redirect_to user_path(current_user)
                return
            else
                watched = current_user.watched_movies.build(:movie_id => result.id)
            end
        end
            if watched.save
                redirect_to user_path(current_user)
            else
            end
    end
    
    def show
        @watched_movie = WatchedMovie.find(params[:id])
        @comments = @watched_movie.comments.all
    end
end
