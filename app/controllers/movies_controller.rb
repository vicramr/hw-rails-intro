class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @all_ratings = Movie.get_all_ratings # Initialization code

      # First, update session using params.
      # Then use session to carry out the logic, ignoring params.
      if params['format'] == 'titlesort' or params['format'] == 'releasedatesort'
        session[:format] = params['format']
      end
      if params.has_key?('ratings')
        current_ratings = params['ratings'].keys
        if current_ratings.length > 0 # Don't overwrite session if all checkboxes are cleared
          session[:ratings] = current_ratings
        end
      end
      if !session.has_key?(:ratings) # In this case, initialize session
        session[:ratings] = Movie.get_all_ratings
      end

      # When using session to carry out logic: first construct
      # arguments to model, then use them, then set shared variables.
      orderby = nil
      if session[:format] == 'titlesort'
        orderby = 'title'
      elsif session[:format] == 'releasedatesort'
        orderby = 'release_date'
      end

      @highlight = orderby
      @movies = Movie.with_ratings_and_ordering(session[:ratings], orderby)
      @prev_ratings_checked = session[:ratings]
    end
  
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end