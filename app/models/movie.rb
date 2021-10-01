class Movie < ActiveRecord::Base
  # ratings: array of strings ("R", "PG", etc)
  def self.with_ratings(ratings)
    Movie.where(rating: ratings) # TODO make case insensitive
  end

  def self.get_all_ratings
    ['G','PG','PG-13','R']
  end
end