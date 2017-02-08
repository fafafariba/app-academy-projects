require_relative 'questionsdb'
require_relative 'reply'
require_relative 'questionfollow'
require_relative 'questionlike'
require_relative 'modelbase'


class Question

  TABLE = "questions"

  def self.all #display all rows of table
    data = QuestionsDB.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_question_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
    SELECT
    *
    FROM
    questions
    WHERE
    #{table_id} = ?
    SQL
    #data returned as array
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDB.instance.execute(<<-SQL, author_id)
    SELECT
    *
    FROM
    users
    JOIN
    questions ON users.id = questions.user_id
    WHERE
    users.id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDB.instance.execute(<<-SQL, fname, lname)
    SELECT
    *
    FROM
    users
    JOIN
    questions ON users.id = questions.user_id
    WHERE
    fname = ? AND lname = ?
    SQL
    #data returned as array
    data.map { |datum| Question.new(datum) }
  end


  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :user_id, :title, :question_id, :body

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def save
    raise "#{self} is already in the dababase" if @id

    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} is not in the the database" unless @id

    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        id = ?
    SQL
    save
  end

  def author
    raise "#{self} is not in the the database" unless @id

    name = QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        users.fname, users.lname
      FROM
        questions
      JOIN
        users ON users.id = questions.user_id
      WHERE
        questions.id = ?
    SQL
    "Author of this question is #{name.first['fname']} #{name.first['lname']}"
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end
