require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = []
    params.each do |k, _|
      where_line << "#{k} = :#{k}"
    end
    where_line = where_line.join(", ")
    p params
    p where_line

    results = DBConnection.execute(<<-SQL, params)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where_line}
      SQL
    p results
  end
end

class SQLObject
  extend Searchable
end
