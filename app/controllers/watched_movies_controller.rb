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
            watched = current_user.watched_movies.build(:movie_id => result.id)
        end
            if watched.save
                redirect_to root_path
            else
            end
    end
    
    def show
        @watched_movie = WatchedMovie.find(params[:id])
        @comments = @watched_movie.comments.all
    end
end
