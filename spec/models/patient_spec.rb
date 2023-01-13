require 'rails_helper'

RSpec.describe Patient do
  it { should have_many :doctor_patients }
  it { should have_many(:doctors).through(:doctor_patients) }
  it { should have_many(:hospitals).through(:doctors) }

  describe 'instance methods' do
    describe '#doctor_patient_by_doctor_id' do
      it 'returns the patients doctor_patient table entry based on doctor id' do
        hospital = Hospital.create!(name: "St. Joseph Hospital")
        doctor1 = hospital.doctors.create!(name: 'Alex Pitzel', specialty: 'Neuromedicine', university: 'Laurentian University')
        patient1 = doctor1.patients.create!(name: 'Ryan Blackstock', age: 30)
        patient2 = doctor1.patients.create!(name: 'Adam Hickey', age: 30)

        expect(patient1.doctor_patient_by_doctor_id(doctor1.id)).to eq(DoctorPatient.first)
        expect(patient2.doctor_patient_by_doctor_id(doctor1.id)).to eq(DoctorPatient.second)
      end
    end
  end
end
