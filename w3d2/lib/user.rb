require_relative 'questionsdb'
require_relative 'question'
require_relative 'reply'
require_relative 'questionfollow'
require_relative 'questionlike'
require_relative 'modelbase'

class User < ModelBase

  TABLE = User.quote("users")

  def self.table
    TABLE
  end

  def self.all #display all rows of table
    super
  end

  def self.find_by_id(id)
    super
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDB.instance.execute(<<-SQL, fname, lname)
    SELECT
    *
    FROM
    users
    WHERE
    fname = ? AND lname = ?
    SQL
    #data returned as array
    data.map { |datum| User.new(datum) }
  end

  attr_accessor :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    raise "#{self} is already in the dababase" if @id

    QuestionsDB.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} is not in the the database" unless @id

    QuestionsDB.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
    save
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(question_id) AS FLOAT )/ COUNT(DISTINCT question_id) AS average_karma
      FROM
        question_likes
      WHERE
        question_id IN (
        SELECT
          id
        FROM
          questions
        WHERE
          user_id = ?
        )
    SQL
  end

end
