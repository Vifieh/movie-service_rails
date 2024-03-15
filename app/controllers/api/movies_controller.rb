class Api::MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /api/movies
  def index
    @movies = Movie.all
    render json: @movies
  end

  # GET /api/movies/:id
  def show
    render json: @movie
  end

  # POST /api/movies
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: @movie, status: :created
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/movies/:id
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/movies/:id
  def destroy
    @movi.destroy
    head :no_content
  end

  # DELETE /api/movies
  def destroy_all
    Movie.delete_all
    head :no_content
  end

  # GET /api/movies?title=
  def search
    @movies = Movie.where("title ILIKE ?", "%#{params[:title]}%")
    render json: @movies
  end

  # GET /ai/movies/recent
  def recent
    @movies = Movie.order(releaseDate: desc).limit(5)
    render json: @movies
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :genre, :releaseDate, :language, :rating)
  end

  def render_not_found_response
    render json: { error: "Artist Not Found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end