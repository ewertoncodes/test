# frozen_string_literal: true

FactoryBot.define do
  factory :resident do
    full_name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    cns { Faker::Number.number(digits: 15) }
    email { Faker::Internet.email }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { ENV['PHONE_NUMBER'] }
    status { 'active' }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'image.jpeg'), 'image/jpeg') }
  end
end
