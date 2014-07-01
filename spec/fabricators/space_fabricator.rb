Fabricator(:space) do
  name { Faker::Name.name }
  street_address { Faker::Address.street_address }
  city { Faker::Address.city }
  country { Faker::Address.country }
  phone { Faker::PhoneNumber.phone_number}
  description { Faker::Lorem.sentence }
end