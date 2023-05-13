# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zip_code { '12345678' }
    street { 'Example Street' }
    complement { 'Apt. 123' }
    neighborhood { 'Example Neighborhood' }
    city { 'Example City' }
    state { 'Example State' }
    ibge_code { '1234567' }
    resident
  end
end
