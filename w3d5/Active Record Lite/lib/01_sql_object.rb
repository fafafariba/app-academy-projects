require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = cols.first.map { |col| col.to_sym }
  end

  def self.finalize!

    self.columns.each do |col_name|
      define_method("#{col_name}=") do |value|

      #define setter
        # puts self.attributes
        self.attributes["#{col_name}".to_sym] = value
        # puts self.attributes
        # puts self.attributes["#{col_name}"]
      end
    end

    self.columns.each do |col_name|
      col_name = col_name.to_s
      define_method("#{col_name}") do
        self.attributes[col_name.to_sym]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = "#{self}".downcase + "s"
  end

  def self.table_name
    @table_name = @table_name || "#{self}".tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
    SELECT #{self.table_name}.*
    FROM #{self.table_name}
    SQL
    parse_all(results)
  end

  def self.parse_all(results)
    results.map do |row|
      self.new(row)
    end
  end

  def self.find(id)
    data = DBConnection.execute(<<-SQL, id)
      SELECT #{self.table_name}.*
      FROM #{self.table_name}
      WHERE #{self.table_name}.id = ?
    SQL
    data.map { |datum| self.new(datum) }.first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      else
        attr_name = attr_name.to_s + "=" #att_name=
        self.send(attr_name.to_sym, value)
      end
    end
  end

  def attributes
    @attributes = @attributes || {}
  end

  def attribute_values
    self.class.columns.map do |col_name|
      send(col_name) unless send(col_name).nil?
        #could you have looked up attribute by col key?
    end
  end

  def insert
    col_names = self.class.columns.join(", ")

    question_marks = []
    self.class.columns.count.times {question_marks << "?"}
    question_marks = question_marks.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update

    col_names = self.class.columns.map do |col_name|
                "#{col_name}= :#{col_name}" unless col_name == :id
              end.compact.join(", ")

    data = DBConnection.execute(<<-SQL, attributes )
      UPDATE
      #{self.class.table_name}
      SET
      #{col_names}
      WHERE
      id = :id
    SQL
    # p data

    #ALTERNATE
    # col_names = self.class.columns.map do |col_name|
    #             "#{col_name}= ?" unless col_name == :id
    #           end.compact.join(", ")
    #
    # p attribute_values_no_id = attribute_values.drop(1)
    #
    #   DBConnection.execute(<<-SQL, *attribute_values_no_id, self.id)
    #   UPDATE
    #   #{self.class.table_name}
    #   SET
    #   #{col_names}
    #   WHERE
    #   id = ?
    # SQL

  end

  def save
    self.id.nil? ? insert : update
  end
end
