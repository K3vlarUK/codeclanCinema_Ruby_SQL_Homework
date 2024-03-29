require_relative('../db/sql_runner.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
          (title, price) VALUES
          ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first()
    @id = film['id'].to_i()
  end

  def update()
    sql = "UPDATE films SET
          (title, price) =
          ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return Customer.map_items(customers)
  end

  ## Check how many customers are going to watch a certain film
  def how_many_customers?()
    customers_booked = customers()
    return customers.length()
  end

  ## Class Methods
  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return Film.map_items(films)
  end

  def self.all_by_price()
    sql = "SELECT * FROM films ORDER BY price"
    films = SqlRunner.run(sql)
    return Film.map_items(films)
  end

  def self.map_items(data)
    result = data.map{ |film| Film.new(film)}
    return result
  end

end
