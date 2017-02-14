def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie
    .select(:title, :id, :yr, :score)
    .where("score BETWEEN ? AND ? AND yr IN (?)", 3, 5, 1980..1989)
end

def bad_years
  # List the years in which a movie with a rating above 7 was not released.
  #AKA BELOW 8
  Movie
    .group(:yr)
    .having("MAX(movies.score) <= ?", 8)
    .pluck(:yr)
    # .pluck("yr, MAX(movies.score)")
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor
    .select('actors.id', 'actors.name')
    .joins(:movies)
    .where("movies.title = ?", title)
    .order("castings.ord ASC")

end

def vanity_projects
  # List the title of all movies in which the director also appeared as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie
    .select(:title, :id, "actors.name")
    .joins(:actors)
    .where("actors.id = movies.director_id AND castings.ord = 1")

end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor
    .select("actors.id, actors.name, COUNT(actors.id) AS roles")
    .joins(:castings)
    .where("castings.ord > 1")
    .group("actors.id")
    .order("COUNT(actors.id) DESC")
    .limit(2)

end