class ImdbMoviesController < ApplicationController
    def index
        i = Imdb::Top250.new
        @movies = i.movies

        if params[:search]
            @movies = Imdb::Search.new(params[:search]).movies
        else
            @movies = i.movies
        end
    end
    
    def show
        @i = Imdb::Movie.new(params[:movie_id])
       
    end
end
