require_relative 'questionsdb'
require_relative 'user'
require_relative 'question'

class Reply

  def self.all #display all rows of table
    data = QuestionsDB.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_user_id(user_id)
    # QuestionsDB.instance.execute("SELECT * FROM users WHERE id = '#{id}'")
    data = QuestionsDB.instance.execute(<<-SQL, user_id)
    SELECT
    *
    FROM
    replies
    WHERE
    replies.user_id = ?
    SQL
    #data returned as array
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    # QuestionsDB.instance.execute("SELECT * FROM users WHERE id = '#{id}'")
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
    SELECT
    *
    FROM
    replies
    WHERE
    replies.question_id = ?
    SQL
    #data returned as array
    data.map { |datum| Reply.new(datum) }
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
    data.map { |datum| Reply.new(datum) }
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
    data.map { |datum| Reply.new(datum) }
  end

  attr_accessor :user_id, :parent_id, :question_id, :body

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @question_id = options['question_id']
    @body = options['body']
  end

  def save
    raise "#{self} is already in the dababase" if @id

    QuestionsDB.instance.execute(<<-SQL, @user_id, @parent_id, @question_id, @body)
      INSERT INTO
        replies (@user_id, @parent_id, @question_id, @body)
      VALUES
        (?, ?, ?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end

  def update
    raise "#{self} is not in the the database" unless @id

    QuestionsDB.instance.execute(<<-SQL, @user_id, @parent_id, @question_id, @body, @id)
      UPDATE
        replies
      SET
        user_id = ?, parent_id = ?, question_id = ?, body = ?
      WHERE
        id = ?
    SQL
    save
  end

  def author
    raise "#{self} is not in the the database" unless @id
    User.find_by_id(@user_id)
  end

  def question
    raise "#{self} is not in the the database" unless @question_id
    Question.find_by_question_id(@question_id)
  end

  def parent_reply
    raise "This reply does not have a parent reply" unless @parent_id

    data = QuestionsDB.instance.execute(<<-SQL, @parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL
    data.map { |datum| Reply.new(datum) }
  end

  def child_replies
    raise "#{self} is not in the the database" unless @id

    data = QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
      SQL
    data.map { |datum| Reply.new(datum) }
  end

end
