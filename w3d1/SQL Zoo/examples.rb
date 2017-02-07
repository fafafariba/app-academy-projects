# Where 'IS' cannot be used (03_select_nobel.rb: 20)

def prizes_from_1950
  # Display Nobel prizes for 1950.
  execute(<<-SQL)
    select
      *
    from
      nobels
    where
      yr = 1950
  SQL
end

#Still doesn't take IS for Strings (03_select_nobel.rb: 44)

def literature_1962
  # Show who won the 1962 prize for Literature.
  execute(<<-SQL)
    SELECT
      winner
    FROM
      nobels
    WHERE
      LOWER(subject) = 'literature'
      AND yr = 1962
  SQL
end

#Can use 'IS' with null

def null_dept
  # List the teachers who have NULL for their department.
  execute(<<-SQL)
    SELECT
      name
    FROM
      teachers
    WHERE
      dept_id IS NULL
  SQL
end

#Proper usage of CASE

#Proper usage of COALESCE
def teachers_and_depts
  # Use the COALESCE function and a LEFT JOIN to print the teacher name and
  # department name. Use the string 'None' where there is no
  # department.
  execute(<<-SQL)
    SELECT
      teachers.name, COALESCE(depts.name, 'None')
    FROM
      teachers
    LEFT OUTER JOIN
      depts ON teachers.dept_id = depts.id

  SQL
end

def teachers_and_divisions
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the the teacher is in dept 1 or 2 and 'Art' otherwise.
  execute(<<-SQL)
    SELECT
      teachers.name,
      CASE
        WHEN dept_id =1 THEN
        'Sci'
        WHEN dept_id = 2 THEN
        'Sci'
        ELSE
        'Art'
      END
    FROM
      teachers
  SQL
end
