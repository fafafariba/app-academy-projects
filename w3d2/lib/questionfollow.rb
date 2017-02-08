require_relative 'questionsdb'
require_relative 'reply'
require_relative 'user'

class QuestionFollow

  def self.all #display all rows of table
    data = QuestionsDB.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| QuestionFollow.new(datum) }
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
    *
    FROM
    users
    JOIN
    question_follows ON question_follows.user_id = users.id
    WHERE
    question_follows.question_id = ?
    SQL

    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDB.instance.execute(<<-SQL, user_id)
    SELECT
    *
    FROM
    questions
    JOIN
    question_follows ON questions.id = question_follows.question_id
    WHERE
    question_follows.user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    QuestionsDB.instance.execute(<<-SQL, n)
    SELECT
    questions.title,
    count(questions.id) as total_follows
    FROM
    questions
    JOIN
    question_follows ON question_follows.question_id = questions.id
    GROUP BY
    questions.id
    ORDER BY
    count(questions.id) desc
    LIMIT
    ?
    SQL
  end

  attr_accessor :user_id, :question_id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
