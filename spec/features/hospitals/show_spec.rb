require 'rails_helper'

RSpec.describe 'The Hospital show page', type: :feature do
  let!(:hospital1) { Hospital.create!(name: "St. Joseph Hospital") }
  let!(:hospital2) { Hospital.create!(name: "Laurentian Hospital") }
  let!(:doctor1) { hospital1.doctors.create!(name: 'Alex Pitzel', specialty: 'Neuromedicine', university: 'Laurentian University') }

  let!(:doctor2) { hospital2.doctors.create!(name: 'Kara Nadeau', specialty: 'Cardiac Rehabilitation', university: 'Nipissing University') }
  let!(:doctor3) { hospital1.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University') }
  let!(:doctor4) { hospital2.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University') }

  let!(:patient1) { doctor1.patients.create!(name: 'Ryan Blackstock', age: 30)}
  let!(:patient2) { doctor1.patients.create!(name: 'Adam Hickey', age: 30)}
  let!(:patient3) { doctor2.patients.create!(name: 'Lisa Kunto', age: 50)}
  let!(:patient4) { doctor2.patients.create!(name: 'Terry Hamilton', age: 48)}
  let!(:patient5) { doctor2.patients.create!(name: 'Joe Pitzel', age: 58)}

  describe 'as a visitor, when I visit the doctors show page' do
    it 'shows the hospitals name' do
      visit hospital_path(hospital1)

      expect(page).to have_content('St. Joseph Hospital')

      visit hospital_path(hospital2)

      expect(page).to have_content('Laurentian Hospital')
    end

    it 'shows the names of all doctors that work there' do
      visit hospital_path(hospital1)

      expect(page).to have_content('Alex Pitzel', count: 1)
      expect(page).to have_content('Meredith Grey', count: 1)
      expect(page).not_to have_content('Kara Nadeau')
      expect(page).not_to have_content('Alex Karev')

      visit hospital_path(hospital2)

      expect(page).to have_content('Kara Nadeau', count: 1)
      expect(page).to have_content('Alex Karev', count: 1)
      expect(page).not_to have_content('Alex Pitzel', count: 1)
      expect(page).not_to have_content('Meredith Grey', count: 1)
    end

    it 'shows the number of patients beside each doctor' do
      patient6 = doctor3.patients.create!(name: 'Katie Bryce', age: 24)
      patient7 = doctor4.patients.create!(name: 'Denny Duquette', age: 39)

      visit hospital_path(hospital1)

      within "#doctor-#{doctor1.id}" do
        expect(page).to have_content(2)
      end

      within "#doctor-#{doctor3.id}" do
        expect(page).to have_content(1)
      end

      visit hospital_path(hospital2)

      within "#doctor-#{doctor2.id}" do
        expect(page).to have_content(3)
      end

      within "#doctor-#{doctor4.id}" do
        expect(page).to have_content(1)
      end
    end

    it 'shows the doctors in order or their patients'
  end
end