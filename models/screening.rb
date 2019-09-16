require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :film_id, :film_title, :start_time, :tickets_sold

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @film_id = options['film_id']
    @film_title = options['film_title']
    @start_time = options['start_time']
    @tickets_sold = 0
  end

  def save()
    sql = "INSERT INTO screenings
          (film_id, film_title, start_time, tickets_sold) VALUES
          ($1, $2, $3, $4) RETURNING id"
    values = [@film_id, @film_title, @start_time, @tickets_sold]
    screening = SqlRunner.run(sql, values).first()
    @id = screening['id'].to_i()
  end

  def update()
    sql = "UPDATE screenings SET
          (film_id, film_title, start_time, tickets_sold) =
          ($1, $2, $3, $4) WHERE id = $5"
    values = [@film_id, @film_title, @start_time, @tickets_sold,@id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def increase_ticket_sold()
    @tickets_sold += 1
  end

  ## Class Methods

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    customers = SqlRunner.run(sql)
    return Screening.map_items(customers)
  end

  def self.map_items(data)
    result = data.map{ |screening| Screening.new(screening)}
    return result
  end

end
