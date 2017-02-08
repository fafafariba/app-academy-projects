require_relative 'questionsdb'
require_relative 'reply'
require_relative 'user'

class QuestionLike

  def self.all #display all rows of table
    data = QuestionsDB.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
    *
    FROM
    users
    JOIN
    question_likes ON question_likes.user_id = users.id
    WHERE
    question_likes.question_id = ?
    SQL

    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
    COUNT(*) AS num_likes
    FROM
    question_likes
    WHERE
    question_likes.question_id = ?
    GROUP BY
    question_likes.question_id
    SQL
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDB.instance.execute(<<-SQL, user_id)
    SELECT
    *
    FROM
    questions
    JOIN
    question_likes ON question_likes.question_id = questions.id
    WHERE
    question_likes.user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    QuestionsDB.instance.execute(<<-SQL, n)
    SELECT
    questions.title,
    COUNT(*) AS num_likes
    FROM
    questions
    JOIN
    question_likes ON questions.id = question_likes.question_id
    GROUP BY
    questions.id
    ORDER BY
    COUNT(*) DESC
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

  def save
    raise "#{self} is already in the dababase" if @id

    QuestionsDB.instance.execute(<<-SQL, @question_id, @user_id)
      INSERT INTO
        question_likes (question_id, user_id)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

end
