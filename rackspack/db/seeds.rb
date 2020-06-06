# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "admin@example.com", password: "123456")
members = [["ashish", "https://stackoverflow.com/"], ["vikash singh", "https://stackoverflow.com/"], ["Naveen", "https://stackoverflow.com/"], ["Krishan", "https://stackoverflow.com/"]] 
members.each_with_index do |member, index|
  m = Member.create(name: member[0], website_url: member[1])
  WebContentWorker.perform_async(m.id)
  if index == 1
    m = Member.first
    Friendship.create(member_id: m.id, friend_id: m.id) 
  elsif index == 2
     m = Member.second
    Friendship.create(member_id: m.id, friend_id: m.id)
  end
end