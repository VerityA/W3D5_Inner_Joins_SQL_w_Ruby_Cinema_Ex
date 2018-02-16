require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()


film1 = Film.new({ 'title' => 'Harry Potter', 'price' => 8.5})
film1.save()

customer1 = Customer.new({ 'name' => 'Verity', 'funds' => 50.0})
customer1.save()

screening1 = Screening.new({ 'show_time' => '13:30', 'screen_num' => 1, 'max_capacity' => 5})
screening1.save()

screening2 = Screening.new({ 'show_time' => '17:30', 'screen_num' => 3, 'max_capacity' => 70})
screening2.save()

screening3 = Screening.new({ 'show_time' => '20:30', 'screen_num' => 2, 'max_capacity' => 150})
screening3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id})
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id})
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id})
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening2.id})
ticket4.save()

ticket5 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening3.id})
ticket5.save()

ticket6 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening3.id})
ticket5.save()

binding.pry

nil
