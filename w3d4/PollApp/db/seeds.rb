# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
james = User.create!(user_name: "jt")
fariba = User.create!(user_name: "fm")
aa = User.create!(user_name: "aa")

poll1 = Poll.create!(title: "Rails", author_id: james.id)
poll2 = Poll.create!(title: "Prez", author_id: fariba.id)

question1 = Question.create!(question: "How much do you like Ruby?", poll_id: poll1.id)
question2 = Question.create!(question: "How much do you like Rails?", poll_id: poll1.id)
question3 = Question.create!(question: "How much do you like SQL?", poll_id: poll1.id)
question4 = Question.create!(question: "Do you like our current prez?", poll_id: poll2.id)
question5 = Question.create!(question: "Who should be the next prez?", poll_id: poll2.id)

answers1 = AnswerChoice.create!(answers: "A lot", question_id: question1.id)
answers2 = AnswerChoice.create!(answers: "A little", question_id: question1.id)
answers3 = AnswerChoice.create!(answers: "A lot", question_id: question2.id)
answers4 = AnswerChoice.create!(answers: "A little", question_id: question2.id)
answers5 = AnswerChoice.create!(answers: "A lot", question_id: question3.id)
answers6 = AnswerChoice.create!(answers: "A little", question_id: question3.id)
answers7 = AnswerChoice.create!(answers: "Love him", question_id: question4.id)
answers8 = AnswerChoice.create!(answers: "Hate him", question_id: question4.id)
answers9 = AnswerChoice.create!(answers: "Michelle Obama", question_id: question5.id)
answers10 = AnswerChoice.create!(answers: "Fariba", question_id: question5.id)
answers11 = AnswerChoice.create!(answers: "James", question_id: question5.id)

response1 = Response.create!(answer_id: answers1.id, user_id: fariba.id)
response2 = Response.create!(answer_id: answers3.id, user_id: fariba.id)
response3 = Response.create!(answer_id: answers5.id, user_id: fariba.id)
response4 = Response.create!(answer_id: answers2.id, user_id: aa.id)
response5 = Response.create!(answer_id: answers4.id, user_id: aa.id)
response6 = Response.create!(answer_id: answers6.id, user_id: aa.id)
response7 = Response.create!(answer_id: answers8.id, user_id: james.id)
response8 = Response.create!(answer_id: answers10.id, user_id: james.id)
