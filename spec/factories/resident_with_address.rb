# frozen_string_literal: true

FactoryBot.define do
  factory :resident_with_address, class: 'Resident' do
    full_name { 'John Doe' }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    cns { '123456789012345' }
    email { 'johndoe@example.com' }
    birth_date { '1990-01-01' }
    phone { ENV['PHONE_NUMBER'] }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'image.jpeg'), 'image/jpeg') }
    status { 'active' }
    address_attributes do
      {
        zip_code: '12345678',
        street: 'Example Street',
        neighborhood: 'Example Neighborhood',
        city: 'Example City',
        state: 'ES',
        complement: 'Example complement'
      }
    end
  end
end
