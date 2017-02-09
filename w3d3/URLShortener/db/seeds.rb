# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

mike1 = User.create!(email: 'mike@email1.com')
fariba = User.create!(email: "f")
user1 = User.create!(email: "1")
user2 = User.create!(email: "2")
user3 = User.create!(email: "3")

visit1 = Visit.create!(shortened_url_id: 1, visitor_id: 1)
visit2 = Visit.create!(shortened_url_id: 4, visitor_id: 2)
visit3 = Visit.create!(shortened_url_id: 4, visitor_id: 3)
visit4 = Visit.create!(shortened_url_id: 3, visitor_id: 4)
visit5 = Visit.create!(shortened_url_id: 2, visitor_id: 5)
visit6 = Visit.create!(shortened_url_id: 4, visitor_id: 1)
visit7 = Visit.create!(shortened_url_id: 3, visitor_id: 2)
visit8 = Visit.create!(shortened_url_id: 3, visitor_id: 2)
visit9 = Visit.create!(shortened_url_id: 3, visitor_id: 1)
