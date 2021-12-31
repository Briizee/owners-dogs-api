require 'faker'

#create 30 owners
(1..30).each do
    Owner.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: Faker::Number.within(range: 15..70), email: Faker::Internet.email)
end

fur_colors = ["Black", "Brown", "Tan", "White", "Red"]

#create 15 dogs
(1..15).each do
    Dog.create(name: Faker::Creature::Dog.name, age: Faker::Number.within(range: 0..12), breed: Faker::Creature::Dog.breed, color: fur_colors.sample(), sex: Faker::Creature::Dog.gender, )
end

#assign random owner(s) to each dog (both number of owners and owners themselves are random)
Dog.find_each do |dog|
    #randomize the number of owners for the dog (between 1 and 3)
    number_of_owners = 1+Random.rand(3)

    #holds array of owner ids 
    owners_array = []

    #fills array with [number_of_owners] random owner ids
    (1..number_of_owners).each do
        owners_array.append(1+Random.rand(30))
    end

    #assigns the owner ids to the dog
    dog.owner_ids = owners_array
end