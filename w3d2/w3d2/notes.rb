# Returns all columns in users only

<<-SQL, question_id: question_id)
SELECT
  users.*
FROM
  users
JOIN
  question_follows
ON
  users.id = question_follows.user_id
WHERE
  question_follows.question_id = :question_id
SQL

#Example of passing in a Hash
def self.find_by_name(fname, lname)
  attrs = { fname: fname, lname: lname }
  user_data = QuestionsDatabase.get_first_row(<<-SQL, attrs)
    SELECT
      users.*
    FROM
      users
    WHERE
      users.fname = :fname AND users.lname = :lname
  SQL

  user_data.nil? ? nil : User.new(user_data)
end

def initialize(options = {})
  @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
end
