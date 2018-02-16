require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end


  def save()
    sql = "INSERT INTO films
    (
      title,
      price
      )
    VALUES (
      $1, $2
      )
      RETURNING id;"
      values = [@title, @price]
      film = SqlRunner.run(sql, values)
      @id = film[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end

  def update()
    sql = " UPDATE films
    SET (
      title,
      price
      )
    =
    ($1, $2)
    WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1;"
    customers = SqlRunner.run(sql, [@id])
    return customers.map { |customer| Customer.new(customer) }
  end

  def customer_count()
    sql = "SELECT COUNT(*) FROM tickets
    WHERE film_id = $1"
    count = SqlRunner.run(sql,[@id])
    return count[0]
    
  end

  def Film.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def Film.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film)  }
  end

end
