require 'faker'
require 'net/http'

# create 30 owners
(1..60).each do
    Owner.create(
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name, 
        age: Faker::Number.within(range: 15..70), 
        email: Faker::Internet.email
    )
end

breeds = JSON.parse(File.read('breeds.json')).keys

# create dogs
breeds.each do |breed|

    # retrieve dog photo from api
    uri_string = "https://dog.ceo/api/breed/#{breed}/images/random"
    uri = URI(uri_string)
    photo_url = JSON.parse(Net::HTTP.get_response(uri).body)['message']

    # fallback dog photo
    photo_url ||= 'https://is2-ssl.mzstatic.com/image/thumb/Purple116/v4/b7/bc/76/b7bc7683-356d-ec96-c581-78a66cee63cd/AppIcon-0-1x_U007emarketing-0-10-0-85-220.png/1200x630wa.png'

    # create the dog
    Dog.create(
        name: Faker::Creature::Dog.name, 
        age: Faker::Number.within(range: 0..12), 
        breed: breed, 
        sex: Faker::Creature::Dog.gender, 
        photo_url: photo_url
    )
end

# assign random owner(s) to each dog (both number of owners and owners themselves are random)
Dog.find_each do |dog|
    # randomize the number of owners for the dog (between 1 and 3)
    number_of_owners = 1+Random.rand(3)

    # holds array of owner ids 
    owners_array = []

    # fills array with [number_of_owners] random owner ids
    (1..number_of_owners).each do
        owners_array.append(Owner.first.id + Random.rand(Owner.last.id - Owner.first.id))
    end

    # assigns the owner ids to the dog
    dog.owner_ids = owners_array
end