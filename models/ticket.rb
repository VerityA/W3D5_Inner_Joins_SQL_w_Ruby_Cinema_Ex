require_relative('../db/sql_runner.rb')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @screening_id = options['screening_id']
  end

  def save()
    sql = "INSERT INTO tickets
      (
      customer_id,
      film_id,
      screening_id
      )
    VALUES (
      $1, $2, $3
      )
      RETURNING id;"
      values = [@customer_id, @film_id, @screening_id]
      ticket = SqlRunner.run(sql, values)
      @id = ticket[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end

  def update()
    sql = "UPDATE tickets
    SET (
      customer_id,
      film_id,
      screening_id
      )
    = (
      $1, $2, $3
      )
    WHERE id = $4;"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def Ticket.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def Ticket.all()
    sql = "SELECT * FROM tickets;"
    tickets = SqlRunner.run(sql)
    return tickets.map { |ticket| Ticket.new(ticket)  }
  end


end
