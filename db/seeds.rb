# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#roles = Role.create([{name: 'Turker'}, {name: 'MeetingsUser'}, {name: 'AssistantUser'}, {name: 'Admin'} ])
#name price credits
plans = Plan.create([{name: 'Free', stripe_id: 'free', price: 0.00, credits: 5}, {name: 'Silver', stripe_id: 'silver', price: 4.99, credits: 20},{name: 'Gold', stripe_id: 'gold', price: 19.99, credits: 100}, {name: 'Platinum', stripe_id: 'platinum',  price: 199.99, credits: 1000}])

google_users = GoogleUser.create({email:'meetings@zenlike.me', google_access_token: 'ya29.AHES6ZRCmoXZbpDeGnNosPtrVI4d2jjA9MRH7x9e2mChkAcI6-UHuw', google_refresh_token: '1/WFt1PuPB3PgWym44Ta9pvWLmIpqOLIkRpivF_JIQHzk', google_expires_at: 1363845687})