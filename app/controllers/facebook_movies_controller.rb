class FacebookMoviesController < ApplicationController
    def index
        @graph = Koala::Facebook::API.new(session[:fb_access_token])
        res = @graph.get_connection('me','video.watches').raw_response
        logger.debug "Filmovi: #{res.class}"


        movies = res["data"]
        logger.debug "Klujc: #{movies.class} "
        
        movies.each do |m|
            
            if m["data"].key?("movie")

                title = m["data"]["movie"]["title"]
                
                list = Imdb::Search.new(title).movies
                logger.debug "#{list.class}"
                unless list.empty?
                    first_movie = list.first
                    unless Movie.exists?(:imdbid => first_movie.id)
                        movie = Imdb::Movie.new(first_movie.id)
                        add = Movie.new(:title => movie.title, :imdbid => movie.id, :poster => movie.poster)
                        if add.save
                        else
                            return
                        end
                        watched = current_user.watched_movies.build(:movie_id => add.id)
                    else
                        result = Movie.where(:imdbid => first_movie.id).first
                        unless current_user.movies.include?(result)
                            watched = current_user.watched_movies.build(:movie_id => result.id)
                        end
                    end
                    watched.save
                end
            end
        end
        redirect_to user_path(current_user)
    end
end