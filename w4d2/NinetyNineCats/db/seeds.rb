# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all

cat1 = Cat.create!(birth_date: Date.parse("2016/01/24"), color: "brown",
        sex: "m", name: "Colin", description: "Colin the cat")
cat2 = Cat.create!(birth_date: Date.parse("2014/12/31"), color: "black",
        sex: "f", name: "Fariba", description: "Fariba the cat")

CatRentalRequest.destroy_all
booking1 = CatRentalRequest.create!(cat_id: cat1.id, start_date:
            Date.parse("2017/02/01"), end_date: Date.parse("2017/02/08"), status: "approved")

booking2 = CatRentalRequest.create!(cat_id: cat1.id, start_date:
            Date.parse("2017/02/09"), end_date: Date.parse("2017/02/11"), status: "approved")
