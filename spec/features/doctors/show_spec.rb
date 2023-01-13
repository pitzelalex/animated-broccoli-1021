require 'rails_helper'

RSpec.describe 'The Doctor show page', type: :feature do
  let!(:hospital1) { Hospital.create!(name: "St. Joseph Hospital") }
  let!(:hospital2) { Hospital.create!(name: "Laurentian Hospital") }
  let!(:doctor1) { hospital1.doctors.create!(name: 'Alex Pitzel', specialty: 'Neuromedicine', university: 'Laurentian University') }

  let!(:doctor2) { hospital2.doctors.create!(name: 'Kara Nadeau', specialty: 'Cardiac Rehabilitation', university: 'Nipissing University') }

  let!(:patient1) { doctor1.patients.create!(name: 'Ryan Blackstock', age: 30)}
  let!(:patient2) { doctor1.patients.create!(name: 'Adam Hickey', age: 30)}
  let!(:patient3) { doctor2.patients.create!(name: 'Lisa Kunto', age: 50)}
  let!(:patient4) { doctor2.patients.create!(name: 'Terry Hamilton', age: 48)}
  let!(:patient5) { doctor2.patients.create!(name: 'Joe Pitzel', age: 58)}

  describe 'as a visitor, when I visit the doctors show page' do
    it 'displays all of that doctors information' do
      visit doctor_path(doctor1)

      expect(page).to have_content('Alex Pitzel')
      expect(page).to have_content('Neuromedicine')
      expect(page).to have_content('Laurentian University')

      visit doctor_path(doctor2)

      expect(page).to have_content('Kara Nadeau')
      expect(page).to have_content('Cardiac Rehab')
      expect(page).to have_content('Nipissing University')
    end

    it 'displays the hospital this doctor works at' do
      visit doctor_path(doctor1)

      expect(page).to have_content('St. Joseph Hospital')

      visit doctor_path(doctor2)

      expect(page).to have_content('Laurentian Hospital')
    end
    it 'lists the names of all the patients this doctor has' do
      visit doctor_path(doctor1)

      expect(page).to have_content('Ryan Blackstock')
      expect(page).to have_content('Adam Hickey')

      visit doctor_path(doctor2)

      expect(page).to have_content('Lisa Kunto')
      expect(page).to have_content('Terry Hamilton')
      expect(page).to have_content('Joe Pitzel')
    end
  end
end
