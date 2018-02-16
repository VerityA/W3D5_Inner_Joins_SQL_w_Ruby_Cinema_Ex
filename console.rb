require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')


film1 = Film.new({ 'title' => 'Harry Potter', 'price' => 8.5})
film1.save()

customer1 = Customer.new({ 'name' => 'Verity', 'funds' => 50.0})
customer1.save()

screening1 = Screening.new({ 'show_time' => '13:30', 'screen_num' => 1, 'max_capacity' => 100})
screening1.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id})
ticket1.save()






binding.pry

nil
