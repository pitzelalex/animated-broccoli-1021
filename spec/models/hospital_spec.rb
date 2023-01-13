require 'rails_helper'

RSpec.describe Hospital do
  it { should have_many :doctors }
  it { should have_many(:doctor_patients).through(:doctors) }
  it { should have_many(:patients).through(:doctor_patients) }

  let!(:hospital1) { Hospital.create!(name: "St. Joseph Hospital") }
  let!(:hospital2) { Hospital.create!(name: "Laurentian Hospital") }
  let!(:doctor1) { hospital1.doctors.create!(name: 'Alex Pitzel', specialty: 'Neuromedicine', university: 'Laurentian University') }

  let!(:doctor2) { hospital2.doctors.create!(name: 'Kara Nadeau', specialty: 'Cardiac Rehabilitation', university: 'Nipissing University') }

  let!(:patient1) { doctor1.patients.create!(name: 'Ryan Blackstock', age: 30)}
  let!(:patient2) { doctor1.patients.create!(name: 'Adam Hickey', age: 30)}
  let!(:patient3) { doctor2.patients.create!(name: 'Lisa Kunto', age: 50)}
  let!(:patient4) { doctor2.patients.create!(name: 'Terry Hamilton', age: 48)}
  let!(:patient5) { doctor2.patients.create!(name: 'Joe Pitzel', age: 58)}

  describe 'intance methods' do
    describe '#patient_count' do
      it 'returns the number of patients a doctor has' do
        expect(doctor1.patient_count).to eq(2)
        expect(doctor2.patient_count).to eq(3)
      end
    end
  end
end
