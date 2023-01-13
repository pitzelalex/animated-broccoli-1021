require 'rails_helper'

RSpec.describe 'The patient index page', type: :feature do
  let!(:hospital1) { Hospital.create!(name: "St. Joseph Hospital") }
  let!(:hospital2) { Hospital.create!(name: "Laurentian Hospital") }
  let!(:doctor1) { hospital1.doctors.create!(name: 'Alex Pitzel', specialty: 'Neuromedicine', university: 'Laurentian University') }

  let!(:doctor2) { hospital2.doctors.create!(name: 'Kara Nadeau', specialty: 'Cardiac Rehabilitation', university: 'Nipissing University') }

  let!(:patient1) { doctor1.patients.create!(name: 'Ryan Blackstock', age: 12)}
  let!(:patient2) { doctor1.patients.create!(name: 'Adam Hickey', age: 30)}
  let!(:patient3) { doctor2.patients.create!(name: 'Lisa Kunto', age: 50)}
  let!(:patient4) { doctor2.patients.create!(name: 'Terry Hamilton', age: 4)}
  let!(:patient5) { doctor2.patients.create!(name: 'Joe Pitzel', age: 58)}
  describe 'as a visitor, when I visit the patient index page' do
    it 'displays the names of all adult patiens (age 18 or more) in alphabetical order' do
      visit patients_path

      expect(page).to_not have_content('Ryan Blackstock')
      expect(page).to_not have_content('Terry Hamilton')
      expect('Adam Hickey').to appear_before('Joe Pitzel')
      expect('Joe Pitzel').to appear_before('Lisa Kunto')
    end
  end
end
