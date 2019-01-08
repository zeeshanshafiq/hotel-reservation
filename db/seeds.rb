# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Restaurant.destroy_all
restaurant1 = Restaurant.create!(name: 'Restaurant1', email: 'restaurant1@example.com', phone: '0111234567')
restaurant1.shifts.create!(name: 'Morning', start_at: 28800, end_at: 39600)
restaurant1.shifts.create!(name: 'Evening', start_at: 64800, end_at: 82800)
restaurant1.tables.create!(name: 'Table1', min_capacity: 1, max_capacity: 5)
restaurant1.tables.create!(name: 'Table2', min_capacity: 4, max_capacity: 20)

restaurant2 = Restaurant.create!(name: 'Restaurant-2', email: 'restaurant2@example.com', phone: '0111234567')
restaurant2.shifts.create!(name: 'Morning', start_at: 28800, end_at: 39600)
restaurant2.shifts.create!(name: 'Evening', start_at: 64800, end_at: 82800)
restaurant2.tables.create!(name: 'Table1', min_capacity: 1, max_capacity: 4)
restaurant2.tables.create!(name: 'Table2', min_capacity: 3, max_capacity: 15)

Guest.destroy_all
guest1 = Guest.create!(name: 'Guest1', email: 'guest1@example.com')
guest2 = Guest.create!(name: 'Guest2', email: 'guest2@example.com')