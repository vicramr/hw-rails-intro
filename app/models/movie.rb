class Movie < ActiveRecord::Base
  # ratings: array of strings ("R", "PG", etc)
  def self.with_ratings(ratings)
    Movie.where(rating: ratings)
  end
end