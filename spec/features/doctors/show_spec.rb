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

      expect(page).to have_content('Alex Pitzel', count: 1)
      expect(page).to have_content('Neuromedicine', count: 1)
      expect(page).to have_content('Laurentian University', count: 1)

      visit doctor_path(doctor2)

      expect(page).to have_content('Kara Nadeau', count: 1)
      expect(page).to have_content('Cardiac Rehab', count: 1)
      expect(page).to have_content('Nipissing University', count: 1)
    end

    it 'displays the hospital this doctor works at' do
      visit doctor_path(doctor1)

      expect(page).to have_content('St. Joseph Hospital', count: 1)

      visit doctor_path(doctor2)

      expect(page).to have_content('Laurentian Hospital', count: 1)
    end

    it 'lists the names of all the patients this doctor has' do
      visit doctor_path(doctor1)

      expect(page).to have_content('Ryan Blackstock', count: 1)
      expect(page).to have_content('Adam Hickey', count: 1)

      visit doctor_path(doctor2)

      expect(page).to have_content('Lisa Kunto', count: 1)
      expect(page).to have_content('Terry Hamilton', count: 1)
      expect(page).to have_content('Joe Pitzel', count: 1)
    end

    it 'has a button next to each patient to remove a patient from the doctor' do
      visit doctor_path(doctor1)

      within "#patient-#{patient1.id}" do
        expect(page).to have_button('Remove')
      end

      within "#patient-#{patient2.id}" do
        expect(page).to have_button('Remove')
      end

      visit doctor_path(doctor2)

      within "#patient-#{patient3.id}" do
        expect(page).to have_button('Remove')
      end

      within "#patient-#{patient4.id}" do
        expect(page).to have_button('Remove')
      end

      within "#patient-#{patient5.id}" do
        expect(page).to have_button('Remove')
      end
    end

    it 'removes a patient from this doctor when that button is clicked' do
      # require 'pry'; binding.pry
      DoctorPatient.create!(doctor_id: doctor1.id, patient_id: patient3.id)
      DoctorPatient.create!(doctor_id: doctor2.id, patient_id: patient1.id)

      visit doctor_path(doctor2)

      expect(page).to have_content('Lisa Kunto', count: 1)
      expect(page).to have_content('Ryan Blackstock', count: 1)

      visit doctor_path(doctor1)

      expect(page).to have_content('Lisa Kunto', count: 1)
      expect(page).to have_content('Ryan Blackstock', count: 1)

      within "#patient-#{patient3.id}" do
        click_button 'Remove'
      end

      expect(current_path).to eq(doctor_path(doctor1))
      expect(page).not_to have_content('Lisa Kunto')

      visit doctor_path(doctor2)
      expect(page).to have_content('Lisa Kunto', count: 1)

      within "#patient-#{patient1.id}" do
        click_button 'Remove'
      end

      expect(current_path).to eq(doctor_path(doctor2))
      expect(page).not_to have_content('Ryan Blackstock')
    end
  end
end
