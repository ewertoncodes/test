# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Resident Index', type: :feature do
  scenario 'displays a table with residents and their addresses' do
    resident = create(:resident_with_address)
    visit residents_path

    expect(page).to have_css('h1', text: 'Residentes')

    within('table') do
      expect(page).to have_content(resident.full_name)
      expect(page).to have_content(resident.cpf)
      expect(page).to have_content(resident.cns)
      expect(page).to have_content(resident.email)
      expect(page).to have_content(resident.birth_date.strftime('%d/%m/%Y'))
      expect(page).to have_content(resident.phone)
      expect(page).to have_content(resident.address.zip_code)
      expect(page).to have_content(resident.address.street)
      expect(page).to have_content(resident.address.neighborhood)
      expect(page).to have_content(resident.address.city)
      expect(page).to have_content(resident.address.state)
      expect(page).to have_content(resident.address.complement)
    end
  end
end
