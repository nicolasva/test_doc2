# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.create kind: 'opening', starts_at: DateTime.parse("2022-08-04 09:30"), ends_at: DateTime.parse("2022-08-04 12:30"), weekly_recurring: true
Event.create kind: 'appointment', starts_at: DateTime.parse("2022-08-04 10:30"), ends_at: DateTime.parse("2022-08-11 11:30")
Event.create kind: 'opening', starts_at: DateTime.parse("2022-08-04 12:30"), ends_at: DateTime.parse("2022-08-11 13:30", weekly_recurring: true)

