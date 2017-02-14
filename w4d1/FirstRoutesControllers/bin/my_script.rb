require 'addressable/uri'
require 'rest-client'

def index_users
    url = Addressable::URI.new(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: '/users.html'
    ).to_s

    puts RestClient.get(url)
end

def create_user(name, email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: { name: name, email: email } }
  )
rescue RestClient::Exception => e
  puts e.message
end

def show_user(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}.json"
  ).to_s

  puts RestClient.get(url)
end

def update_user(id, name, email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}.json"
  ).to_s

  puts RestClient.patch(
    url,
    { user: { name: name, email: email } }
  )
end

def delete_user(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}.json"
  ).to_s

  puts RestClient.delete(url)
end

def create_contact(user_id, name, email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts.json'
  ).to_s

  puts RestClient.post(
    url,
    { contact: { name: name, email: email, user_id: user_id } }
  )
rescue RestClient::Exception => e
  puts e.message
end

def update_contact(id, user_id, name, email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/contacts/#{id}.json"
  ).to_s

  puts RestClient.patch(
    url,
    { contact: { name: name, email: email, user_id: user_id } }
  )
end

def delete_contact(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/contacts/#{id}.json"
  ).to_s

  puts RestClient.delete(url)
end

update_contact(3, 3, "App Academy Student", "aa@aa.com")


# create_user("darth vader", "dv@dv.com")

# def new_users
#     url = Addressable::URI.new(
#       scheme: 'http',
#       host: 'localhost',
#       port: 3000,
#       path: '/users/new',
#       # query_values: {
#       #   'some_category[a_key]' => 'another value',
#       #   'some_category[a_second_key]' => 'yet another value',
#       #   'some_category[inner_inner_hash][key]' => 'value',
#       #   'something_else' => 'aaahhhhh' }
#     ).to_s
#
#     puts RestClient.get(url)
# end

index_users
