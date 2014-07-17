Fabricator(:user) do
  full_name { Faker::Name.name }
  username { Faker::Name.first_name }
  email { Faker::Internet.email }
  country { Faker::Address.country }
  password "password"
  admin false
end

Fabricator(:admin, from: :user) do
  admin true
end