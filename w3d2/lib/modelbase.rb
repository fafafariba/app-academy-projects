require 'sqlite3'
require_relative 'questionsdb'

class ModelBase

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table}
      WHERE
        id = ?
    SQL
    #data returned as array
     data.map { |datum| self.new(datum) }
  end

  def self.all
    data = QuestionsDB.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table}
    SQL
    data.map { |datum| self.new(datum) }
  end
end
