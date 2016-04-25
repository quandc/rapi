# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

User.create!(email: 'abc123@example.com', password: '12345678',
	password_confirmation: '12345678')
user = User.first
for i in (2..100)
	m = Message.new
	m.id = i
	m.user = user
	m.category = Faker::Lorem.word
	m.content = Faker::Lorem.sentence
	m.save!
end

