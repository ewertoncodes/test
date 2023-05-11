require 'rails_helper'

RSpec.feature "Create Resident", type: :feature do
  scenario "User creates a new resident" do
    visit new_resident_path

    fill_in "Full name", with: "John Doe"
    fill_in "Cpf", with: "74178883216"
    fill_in "Cns", with: "123456789012345"
    fill_in "Email", with: "john.doe@example.com"
    fill_in "Birth date", with: "01/01/1980"
    fill_in "Phone", with: "(00) 00000-0000"
    attach_file "Photo", Rails.root.join('spec', 'fixtures', 'image.jpeg')
    select "inactive", from: "Status"

    click_button "Create Resident"

    # expect(page).to have_content("Resident was successfully created.")
    expect(page).to have_content("John Doe")
    # expect(page).to have_content("12345678901")
    # expect(page).to have_content("123456789012345")
    # expect(page).to have_content("john.doe@example.com")
    # expect(page).to have_content("01/01/1980")
    # expect(page).to have_content("(00) 00000-0000")
  end
end
