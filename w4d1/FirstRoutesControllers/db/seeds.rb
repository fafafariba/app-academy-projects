# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Contact.destroy_all
ContactShare.destroy_all


josh = User.create!(username: 'josh')
fariba = User.create!(username: 'fariba')

gizmo = Contact.create!(name: 'Gizmo', email: 'gizmo@gizmo.com', user_id: josh.id)
dv = Contact.create!(name: 'D. Vader', email: 'dv@gdv.com', user_id: fariba.id)

ContactShare.create!(contact_id: gizmo.id, user_id: fariba.id)
#ContactShare.create!(contact_id: dv.id, user_id: josh.id)
