######################
# CLEAN SLATE
######################
User.destroy_all

######################
# USER CREATION
######################
amount_of_users = 20
puts '=============='
puts 'CREATING USERS'
puts '=============='
3.times { puts }

amount_of_users.times do |i|
  name = Faker::Name.unique.name
  username = Faker::Artist.unique.name
  User.create!(name: name, username: username)
  puts "- User ##{i} created with name: #{name} and username: #{username}."
end

3.times { puts }
puts '======================='
puts "USERS HAVE BEEN CREATED"
puts '======================='
3.times { puts }


######################
# EVENT CREATION
######################

amount_of_events = 100
puts '================'
puts 'CREATING EVENTS'
puts '================'
3.times { puts }
amount_of_events.times do |i|
  description = Faker::Hipster.sentence(word_count: 3)
  location = Faker::Address.full_address
  creator = User.find(rand(1..User.count))
  invitees = User.all_except(creator).take(rand(5..35))

  ####################################################################
  # Date is added randomly to incorporate previous and upcoming events
  ####################################################################
  event = Event.new(creator: creator, 
                    description: description,
                    location: location)

  if rand(1..10).even?
    #################
    # Previous events
    #################
    #
    # Set date in the past
    #

    date = rand(1..1_000).minutes.ago

    event.date = date
    event.save

    puts '==================='
    puts 'Past event created.'
    puts '==================='
    
    event.attendees << invitees

    puts 'List of attendees'.
    puts '==========================='

    event.attendees.each do |attendee|
      puts "#{attendee.name} attended."
    end
    puts '==========================='
    puts

    #
    # Send out and accept all invitations
    #

    puts 'List of invitations'
    puts '================================'
    event.attendees.each do |attendee|
      event.invitations.create!(event: event,
                               invitee: attendee,
                               accepted: true) 
      puts "#{attendee.name} was sent an invitation and accepted it."
    end
    puts '================================'
    puts
  else
    #################
    # Upcoming events
    #################
    #
    # Set date in the future
    #

    date = rand(1..1_000).minutes.from_now

    event.date = date
    event.save
    puts '====================='
    puts "Future event created."
    puts '====================='
    puts

    #
    # Send out and accept a couple invitations
    #

    puts 'List of invitations'
    puts '==========================='
    invitees.each do |invitee|
      invitation = event.invitations.create!(event: event,
                                invitee: invitee)

      puts "An invitation was sent to #{invitee.name}."

      if rand(1..10).even?
        invitation.update(accepted: true)
        event.attendees << invitee
        puts "-> The invitation was accepted and was added to the guest list."
      end
    end
    puts '==========================='
  end
end

puts "========================"
puts "EVENTS HAVE BEEN CREATED."
puts "========================"

3.times { puts }
puts "================"
puts "DATABASE SEEDED."
puts "================"

