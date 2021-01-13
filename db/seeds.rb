######################
# CLEAN SLATE
######################
Invitation.destroy_all
Event.destroy_all
User.destroy_all

######################
# USER CREATION
######################
amount_of_users = 20
puts 'CREATING USERS'
amount_of_users.times do |i|
  name = Faker::Name.unique.name
  username = Faker::Artist.unique.name
  User.create!(name: name, username: username)
  puts "User ##{i} created with name: #{name} and username: #{username}."
end
puts "======================="
puts "USERS HAVE BEN CREATED"
puts "======================="


######################
# EVENT CREATION
######################

amount_of_events = 100
puts 'CREATING EVENTS'
amount_of_events.times do |i|
  description = Faker::Hipster.sentence(word_count: 3)
  location = Faker::Address.full_address
  invitees = User.take(rand(5..35))
  creator_id = rand(1..User.count)

  ####################################################################
  # Date is added randomly to incorporate previous and upcoming events
  ####################################################################
  event = Event.new(creator: User.find(creator_id),
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

    puts "Past event created."
    
    event.attendees << invitees

    event.attendees.each do |attendee|
      puts "#{attendee.name} attended."
    end

    #
    # Send out and accept all invitations
    #

    event.attendees.each do |attendee|
      event.invitations.create!(event: event,
                               invitee: attendee,
                               accepted: true) 
      puts "#{attendee.name} was sent an invitation and accepted it."
    end
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
    puts "Future event created."

    #
    # Send out and accept a couple invitations
    #

    invitees.each do |invitee|
      invitation = event.invitations.create!(event: event,
                                invitee: invitee)

      puts "An invitation was sent to #{invitee.name}."

      if rand(1..10).even?
        invitation.update(accepted: true)
        event.attendees << invitee
        puts "The invitation was accepted and was added to the guest list."
      end
    end
  end
end

puts "============================="
puts "EVENTS HAVE BEEN CREATED."
puts "============================="
puts "============================="
puts "============================="
puts "DATABASE HAS BEEN SEEDED."

