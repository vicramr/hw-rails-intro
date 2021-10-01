class Movie < ActiveRecord::Base
  # ratings: array of strings ("R", "PG", etc)
  def self.with_ratings(ratings)
    Movie.where(rating: ratings) # TODO make case insensitive
  end

  # if ratings is non-nil, filter by it. If orderby is non-nil, sort by it.
  # Note: in practice I am not using some of this logic, as ratings is always non-nil
  def self.with_ratings_and_ordering(ratings, orderby)
    if ratings == nil
      if orderby == nil
        return Movie.all
      else
        return Movie.order(orderby)
      end
    else
      if orderby == nil
        return Movie.where(rating: ratings)
      else
        return Movie.where(rating: ratings).order(orderby)
      end
    end
  end

  def self.get_all_ratings
    ['G','PG','PG-13','R']
  end
end