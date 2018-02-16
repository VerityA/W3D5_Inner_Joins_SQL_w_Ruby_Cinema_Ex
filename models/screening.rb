require_relative('../db/sql_runner.rb')

class Screening

  attr_reader :id, :screen_num, :max_capacity
  attr_accessor :show_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @screen_num = options['screen_num']
    @max_capacity = options['max_capacity']
  end

  def save()
    sql = "INSERT INTO screenings
      (
      show_time,
      screen_num,
      max_capacity
      )
    VALUES (
      $1, $2, $3
      )
    RETURNING id;"
    values = [@show_time, @screen_num, @max_capacity]
    screening = SqlRunner.run(sql, values)
    @id = screening[0]['id'].to_i
  end



end
