require_relative('../db/sql_runner.rb')
require_relative('film.rb')
require_relative('screening.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
      )
    VALUES (
      $1, $2
      )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)
    @id = customer[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end

  def update()
    sql = "UPDATE customers
    SET (
      name,
      funds
      )
    = (
      $1, $2
      )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    films = SqlRunner.run(sql, [@id])
    return films.map { |film| Film.new(film) }
  end

  def buy_ticket(film, ticket, screening)
    return if film.customers_at_particular_screening_count(screening) >= screening.max_capacity()
    @funds -= film.price()
    sql = "UPDATE customers
    SET (
      name,
      funds)
    = ($1, $2)
    WHERE id = $3;"
    values = [@name, @funds]
    update()
    ticket.save()
  end

  def ticket_count()
    sql = "SELECT COUNT(*) FROM tickets
    WHERE customer_id = $1
    "
    count = SqlRunner.run(sql, [@id])
    return count[0]
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def Customer.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer)  }
  end

end
