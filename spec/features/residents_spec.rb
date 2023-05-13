# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Create Resident', type: :feature do
  scenario 'User creates a new resident with address' do
    visit new_resident_path

    fill_in 'Full name', with: 'John Doe'
    fill_in 'Cpf', with: '272.366.503-82'
    fill_in 'Cns', with: '123456789012345'
    fill_in 'Email', with: 'john.doe@example.com'
    fill_in 'Birth date', with: '01/01/1980'
    fill_in 'Phone', with: ENV['PHONE_NUMBER']
    attach_file 'Photo', Rails.root.join('spec', 'fixtures', 'image.jpeg')
    select 'active', from: 'Status'

    fill_in 'Zip', with: '12345-678'
    fill_in 'Street', with: 'Example Street'
    fill_in 'Complement', with: ''
    fill_in 'Neighborhood', with: 'Example Neighborhood'
    fill_in 'City', with: 'Example City'
    fill_in 'State', with: 'EX'
    fill_in 'Ibge', with: ''

    click_button 'Create Resident'

    expect(page).to have_content('Resident was successfully created.')
  end
end
