require ('pry')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require_relative('./models/film.rb')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

#### Customers Created and Saved
customer1 = Customer.new({
  'name' => 'Kevin McDermott',
  'funds' => 50
  })

customer1.save()

customer2 = Customer.new({
  'name' => 'Niall Morris',
  'funds' => 60
  })

customer2.save()

customer3 = Customer.new({
  'name' => 'Colin Bell',
  'funds' => 100
  })

customer3.save()
customer3.name = 'Anna Henderson'
customer3.update()

customer4 = Customer.new({
  'name' => 'Colin Bell',
  'funds' => 80
  })

customer4.save()

##### Films Created and Saved
film1 = Film.new({
  'title' => 'Shaun of the Dead',
  'price' => 15
  })

film1.save()

film2 = Film.new({
  'title' => 'Hot Fuzz',
  'price' => 12
  })

film2.save()

film3 = Film.new({
  'title' => 'The Worlds End',
  'price' => 8
  })

film3.save()
film3.price = 5
film3.update()

#### Tickets created and saved
ticket1 = Ticket.new({
  'customer_id' => customer1.id(),
  'film_id' => film1.id()
  })
customer1.pay_for_tickets(film1)
customer1.update()

ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer1.id(),
  'film_id' => film3.id()
  })
customer1.pay_for_tickets(film3)
customer1.update()

ticket2.save()

ticket3 = Ticket.new({
  'customer_id' => customer4.id(),
  'film_id' => film2.id()
  })
customer4.pay_for_tickets(film2)
customer4.update()

ticket3.save()

customer3.delete()

all_customers = Customer.all()
all_films = Film.all()
all_tickets = Ticket.all()

binding.pry
nil
