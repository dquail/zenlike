# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#roles = Role.create([{name: 'Turker'}, {name: 'MeetingsUser'}, {name: 'AssistantUser'}, {name: 'Admin'} ])
#name price credits
plans = Plan.create([{name: 'Silver', stripe_id: 'silver', price: 4.99, credits: 20},{name: 'Gold', stripe_id: 'gold', price: 19.99, credits: 100}, {name: 'Platinum', stripe_id: 'platinum',  price: 199.99, credits: 1000}])