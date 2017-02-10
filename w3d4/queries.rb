# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer


def find_angelina
  #find Angelina Jolie by name in the actors table

end

def top_titles
  # get movie titles from movies with scores greater than or equal to 9
  # hint: use 'select' and 'where'
  Movie.select(:title, :id).where('score >= 9')
  Movie.select(:title, :id).where('score >= ?', 9)
  Movie.select(:title, :id).where('score >= #{value}', value = 9)
  Movie.select(:title, :id).where( { score: 9 }) #if score is 9, not comparative
  Movie.select(:title, :id).where( { score: (9..10) }) #if score is 9, not comparative
  Movie.select(:title, :id).where("score BETWEEN ? and ? ", 9, 10) #if score is 9, not comparative
  Movie.select(:title, :id).where('score >= value', :value => 9 || value: 9 || 'value' => 9)
  Movie.select("title, id, COUNT(*)")

end

def star_wars
  #display the id, title and year of each Star Wars movie in movies.
  # hint: use 'select' and 'where'
  Movie.select("title").where...  
  Movie.select(:title, :id).where("title LIKE '%Star%Wars%' ") WHERE title LIKE "Star Wars%"
  Movie.select(:title)
  title.split(" ") = title_list
  WHERE "Star" IN title_list AND "Wars" IN title_list

<<-SQL
  WHERE
    title LIKE "Star Wars%"
SQL

      .select
      .joins
      .where
      .group
      .having
      .order
      .distinct
      .limit
      .count
end


def below_average_years
  #display each year with movies scoring under 5,
  #with the count of movies scoring under 5 aliased as bad_movies,
  #in descending order
  # hint: use 'select', 'where', 'group', 'order'

end

def alphabetized_actors
  # display the first 10 actor names ordered from A-Z
  # hint: use 'order' and 'limit'
  # Note: Ubuntu users may find that special characters
  # are alphabetized differently than the specs.
  # This spec might fail for Ubuntu users. It's ok!

end

def pulp_fiction_actors
  # practice using joins
  # display the id and name of all actors in the movie Pulp Fiction
  # hint: use 'select', 'joins', 'where'

end

def uma_movies
  #practice using joins
  # display the id, title, and year of movies Uma Thurman has acted in
  # order them by ascending year
  # hint: use 'select', 'joins', 'where', and 'order'

end
